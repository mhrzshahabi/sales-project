package com.nicico.sales.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.common.dto.response.storage.DownloadResponse;
import com.nicico.copper.common.dto.response.storage.UploadResponse;
import com.nicico.copper.common.web.client.StorageClient;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IFileService;
import com.nicico.sales.model.entities.base.File;
import com.nicico.sales.model.enumeration.EFileStatus;
import com.nicico.sales.repository.FileDAO;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Service
public class FileService implements IFileService {

    private final ModelMapper modelMapper;
    private final ObjectMapper objectMapper;
    private final StorageClient storageClient;

    private final FileDAO fileDAO;

    // ---------------

    @Value("${spring.application.name}")
    private String appId;

    @Override
    @Transactional(readOnly = true)
    public List<FileDTO.FileMetaData> getAll(List<Long> ids) {
        return modelMapper.map(fileDAO.findAllById(ids), new TypeToken<List<FileDTO.FileMetaData>>() {
        }.getType());
    }

    @Override
    @Transactional
    public void createFiles(Long recordId, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws Exception {
        int bound = fileData.size();
        for (int index = 0; index < bound; index++) {
            try {
                fileData.get(index).setFile(files.get(index)).setRecordId(recordId);
                store(modelMapper.map(fileData.get(index), FileDTO.Request.class));
            } catch (Exception e) {
                log.error(Arrays.toString(e.getStackTrace()));
                throw e;
            }
        }
    }

    @Override
    @Transactional
    public void updateFiles(Long recordId, String entityName, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws Exception {
        final List<FileDTO.FileMetaData> savedFileData = getFiles(recordId, entityName);
        if (fileData.size() == 0 && savedFileData.size() == 0) return;

        int bound = fileData.size();
        for (int index = 0; index < bound; index++) {
            try {
                fileData.get(index).setFile(files.get(index)).setRecordId(recordId);
                if (fileData.get(index).getId() == null)
                    store(modelMapper.map(fileData.get(index), FileDTO.Request.class));
            } catch (Exception e) {
                log.error(Arrays.toString(e.getStackTrace()));
                throw e;
            }
        }

        for (FileDTO.FileMetaData metaData : savedFileData.stream().filter(q -> q.getFileStatus() != EFileStatus.DELETED && fileData.stream().noneMatch(p -> q.getId().equals(p.getId()))).collect(Collectors.toList()))
            try {
                delete(metaData.getFileKey());
            } catch (Exception e) {
                log.error(Arrays.toString(e.getStackTrace()));
                throw e;
            }
    }

    @Override
    @Transactional
    public String store(FileDTO.Request request) throws Exception {
        Map<String, String> tags = new HashMap<>();
        if (!StringUtils.isEmpty(request.getTags()))
            tags = objectMapper.readValue(request.getTags(), new TypeReference<HashMap<String, Object>>() {
            });

        final UploadResponse uploadResponse = storageClient.upload(appId.toLowerCase(), tags, request.getFile());
        //ToDo: Check upload response status

        final File file = new File()
                .setEntityName(request.getEntityName())
                .setRecordId(request.getRecordId())
                .setFileKey(uploadResponse.getKey())
                .setFileStatus(EFileStatus.NORMAL)
                .setAccessLevel(request.getAccessLevel())
                .setPermissions(request.getPermissions())
                .setOwnerId(SecurityUtil.getUserId());

        fileDAO.saveAndFlush(file);
        return uploadResponse.getKey();
    }

    @Override
    public FileDTO.Response retrieve(String key) {
        final File file = accessCheck(key, EFileStatus.NORMAL);

        final DownloadResponse downloadResponse = storageClient.download(appId.toLowerCase(), key);
        // ToDo: Check download response status

        final Map<String, String> tags = new HashMap<>();
        downloadResponse.getTags().forEach(tag -> tags.put(tag.getKey(), tag.getValue()));

        return new FileDTO.Response()
                .setContent(downloadResponse.getContent())
                .setFileName(tags.getOrDefault("OriginalFileName", "no-name"))
                .setExtension(tags.getOrDefault("OriginalFileExtension", ""))
                .setContentType(tags.getOrDefault("ContentType", ""))
                .setTags(tags)
                .setAccessLevel(file.getAccessLevel())
                .setPermissions(file.getPermissions());
    }

    @Override
    @Transactional(readOnly = true)
    public List<FileDTO.FileMetaData> getFiles(Long recordId, String entityName) {
        List<File> files = fileDAO.findAllByRecordIdAndEntityName(recordId, entityName).stream()
                .filter(file -> EFileStatus.NORMAL.equals(file.getFileStatus()))
                .filter(file -> SecurityUtil.isAdmin() || !EFileAccessLevel.SELF.equals(file.getAccessLevel()) || SecurityUtil.getUserId().equals(file.getOwnerId()))
                .collect(Collectors.toList());

        return modelMapper.map(files, new TypeToken<List<FileDTO.FileMetaData>>() {
        }.getType());
    }

    @Override
    @Transactional(readOnly = true)
    public List<FileDTO.FileMetaData> getFiles(String entityName) {
        List<File> files = fileDAO.findAllByEntityName(entityName).stream()
                .filter(file -> EFileStatus.NORMAL.equals(file.getFileStatus()))
                .filter(file -> SecurityUtil.isAdmin() || !EFileAccessLevel.SELF.equals(file.getAccessLevel()) || SecurityUtil.getUserId().equals(file.getOwnerId()))
                .collect(Collectors.toList());

        return modelMapper.map(files, new TypeToken<List<FileDTO.FileMetaData>>() {
        }.getType());
    }

    @Override
    @Transactional
    public void delete(String key) {
        final File file = accessCheck(key, EFileStatus.NORMAL);

        file.setFileStatus(EFileStatus.DELETED);
        fileDAO.saveAndFlush(file);
    }

    @Override
    @Transactional
    public void restore(String key) {
        final File file = accessCheck(key, EFileStatus.DELETED);

        file.setFileStatus(EFileStatus.NORMAL);
        fileDAO.saveAndFlush(file);
    }

    private File accessCheck(String key, EFileStatus fileStatus) {
        final File file = fileDAO.findByFileKey(key)
                .orElseThrow(() -> new SalesException2(ErrorType.NotFound, "fileKey", "فایل مورد نظر یافت نشد."));

        if (!fileStatus.equals(file.getFileStatus())) {
            throw new SalesException2(ErrorType.NotFound, "fileKey", "فایل مورد نظر یافت نشد.");
        }

        if (!SecurityUtil.isAdmin() && EFileAccessLevel.SELF.equals(file.getAccessLevel()) && !SecurityUtil.getUserId().equals(file.getOwnerId())) {
            throw new SalesException2(ErrorType.NotFound, "fileKey", "فایل مورد نظر خصوصی می باشد و تنها کاربر ایجاد کننده یا مدیر سیستم امکان دانلود یا تغییر آن را دارد.");
        }

        if (!StringUtils.isEmpty(file.getPermissions()) && !SecurityChecker.check(file.getPermissions())) {
            throw new SalesException2(ErrorType.Forbidden, "fileKey", "شما دسترسی های لازم برای دریافت فایل مورد نظر را ندارید.");
        }

        return file;
    }
}
