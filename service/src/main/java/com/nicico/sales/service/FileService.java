package com.nicico.sales.service;

import com.nicico.copper.base.IErrorCode;
import com.nicico.copper.base.NICICOException;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.copper.core.service.minio.EFileStatus;
import com.nicico.copper.core.service.minio.MinIODTO;
import com.nicico.copper.core.service.minio.MinIOService;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IFileService;
import com.nicico.sales.model.entities.base.File;
import com.nicico.sales.model.enumeration.FileStatus;
import com.nicico.sales.repository.FileDAO;
import com.nicico.sales.utility.SecurityChecker;
import io.minio.GetObjectTagsArgs;
import io.minio.MinioClient;
import io.minio.SetObjectTagsArgs;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Service
public class FileService implements IFileService {

    private final ModelMapper modelMapper;

    private final MinioClient minioClient;
    private final MinIOService minIOService;

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

        for (FileDTO.FileMetaData metaData : savedFileData.stream().filter(q -> q.getFileStatus() != FileStatus.DELETED && fileData.stream().noneMatch(p -> q.getId().equals(p.getId()))).collect(Collectors.toList()))
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

        final MinIODTO.Request fileRequest = modelMapper.map(request, MinIODTO.Request.class);
        final String fileKey = minIOService.store(fileRequest);

        final File file = new File()
                .setEntityName(request.getEntityName())
                .setRecordId(request.getRecordId())
                .setFileKey(fileKey)
                .setFileStatus(FileStatus.NORMAL)
                .setAccessLevel(request.getAccessLevel());

        fileDAO.saveAndFlush(file);
        return fileKey;
    }

    @Override
    public FileDTO.Response retrieve(String key) throws Exception {

        final Map<String, String> tags = this.minioClient.getObjectTags(GetObjectTagsArgs.builder().bucket(appId.toLowerCase()).object(key).build()).get();
        if (tags.containsKey("Permission") && !SecurityChecker.check(tags.get("Permission"))) {
            throw new SalesException2(ErrorType.Forbidden, "fileKey", "شما دسترسی های لازم برای دریافت فیل مورد نظر را ندارید.");
        }

        return modelMapper.map(minIOService.retrieve(key), FileDTO.Response.class);
    }

    @Override
    @Transactional(readOnly = true)
    public List<FileDTO.FileMetaData> getFiles(Long recordId, String entityName) {

        return modelMapper.map(fileDAO.findAllByRecordIdAndEntityName(recordId, entityName), new TypeToken<List<FileDTO.FileMetaData>>() {
        }.getType());
    }

    @Override
    @Transactional
    public void delete(String key) throws Exception {

        final File file = fileDAO.findByFileKey(key)
                .orElseThrow(() -> new SalesException2(ErrorType.NotFound, "fileKey", "فایل مورد نظر یافت نشد."));
        minIOService.delete(key);
        try {
            file.setFileStatus(FileStatus.DELETED);
            fileDAO.saveAndFlush(file);
        } catch (Exception e) {
            log.error(Arrays.toString(e.getStackTrace()));
            restore(key);

            throw e;
        }
    }

    @Override
    @Transactional
    public void restore(String key) throws Exception {

        final File file = fileDAO.findByFileKey(key)
                .orElseThrow(() -> new SalesException2(ErrorType.NotFound, "fileKey", "فایل مورد نظر یافت نشد."));

        final Map<String, String> tags = new HashMap<>(this.minioClient.getObjectTags(GetObjectTagsArgs.builder().bucket(appId.toLowerCase()).object(key).build()).get());
        if (EFileStatus.DELETED.equals(EFileStatus.valueOf(tags.get("Status")))) {
            throw new NICICOException(IErrorCode.NotFound);
        } else if (EFileAccessLevel.SELF.equals(EFileAccessLevel.valueOf(tags.get("AccessLevel"))) && !Objects.equals(SecurityUtil.getUserId(), Long.valueOf(tags.get("CreatedBy")))) {
            throw new NICICOException(IErrorCode.Forbidden);
        }

        tags.replace("Status", EFileStatus.NORMAL.getValue());
        tags.put("ModifiedBy", String.valueOf(SecurityUtil.getUserId()));
        tags.put("ModifiedDate", String.valueOf((new Date()).getTime()));
        this.minioClient.setObjectTags(SetObjectTagsArgs.builder().bucket(appId.toLowerCase()).object(key).tags(tags).build());

        try {
            file.setFileStatus(FileStatus.NORMAL);
            fileDAO.saveAndFlush(file);
        } catch (Exception e) {
            log.error(Arrays.toString(e.getStackTrace()));
            delete(key);

            throw e;
        }
    }
}
