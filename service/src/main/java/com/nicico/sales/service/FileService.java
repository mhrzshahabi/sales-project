package com.nicico.sales.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.core.SecurityUtil;
import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.dto.StorageDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IFileService;
import com.nicico.sales.iservice.IStorageApiService;
import com.nicico.sales.model.entities.base.File;
import com.nicico.sales.model.enumeration.EFileStatus;
import com.nicico.sales.repository.FileDAO;
import com.nicico.sales.utility.SecurityChecker;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ContentDisposition;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotNull;
import java.io.*;
import java.nio.file.Files;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Service
public class FileService implements IFileService {

    private final ModelMapper modelMapper;
    private final ObjectMapper objectMapper;
    private final IStorageApiService storageApiService;

    private final FileDAO fileDAO;

    // ---------------

    @Value("${spring.application.name}")
    private String appId;
    @Value("${nicico.upload.dir}")
    private String uploadDir;
    private final String localFileDir = "/minio";

    @Override
    @Transactional(readOnly = true)
    public List<FileDTO.FileMetaData> getAll(List<Long> ids) {
        return modelMapper.map(fileDAO.findAllById(ids), new TypeToken<List<FileDTO.FileMetaData>>() {
        }.getType());
    }

    @Override
    @Transactional
    public void createFiles(Long recordId, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws IOException {
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
    public void updateFiles(Long recordId, String entityName, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws IOException {
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
    public String store(FileDTO.Request request) throws IOException {

        String fileKey;
        StorageDTO.StoreResponse storeResponse = null;
        try {
            storeResponse = storageApiService.store(request.getFile(), request.getTags());
            fileKey = storeResponse.getKey();
        } catch (Exception e) {
            fileKey = storeFileInApp(request.getFile(), request.getTags());
        }

        if (storeResponse != null && storeResponse.getStatus() != 200) {
            throw new SalesException2(ErrorType.InternalServerError, null, storeResponse.getMessage());
        }

        final File file = new File()
                .setEntityName(request.getEntityName())
                .setRecordId(request.getRecordId())
                .setFileKey(fileKey)
                .setFileStatus(EFileStatus.NORMAL)
                .setAccessLevel(request.getAccessLevel())
                .setPermissions(request.getPermissions())
                .setOwnerId(SecurityUtil.getUserId());

        fileDAO.saveAndFlush(file);

        return fileKey;
    }

    @Override
    public FileDTO.Response retrieve(String key) throws IOException {

        List<StorageDTO.Tag> tagsResponse;
        StorageDTO.InfoResponse infoResponse = null;
        StorageDTO.RetrieveResponse retrieveResponse;
        final File file = accessCheck(key, EFileStatus.NORMAL);
        try {
            retrieveResponse = storageApiService.retrieve(key);
            infoResponse = storageApiService.info(key);
            tagsResponse = infoResponse.getTags();

            if (retrieveResponse != null && retrieveResponse.getContentLength() < 0) {

                StorageDTO.RetrieveResponseInApp retrieveResponseInApp = retrieveFileInApp(key);
                tagsResponse = retrieveResponseInApp.getTagsResponse();
                retrieveResponse = retrieveResponseInApp;
            }

        } catch (Exception e) {
            StorageDTO.RetrieveResponseInApp retrieveResponseInApp = retrieveFileInApp(key);
            tagsResponse = retrieveResponseInApp.getTagsResponse();
            retrieveResponse = retrieveResponseInApp;
        }

        final Map<String, Object> tags = new HashMap<>();
        if (tagsResponse != null)
            tagsResponse.forEach(tag -> tags.put(tag.getKey(), tag.getValue()));

        if (retrieveResponse.getContentLength() < 0 && infoResponse != null && infoResponse.getStatus() == 100)
            throw new SalesException2(ErrorType.InternalServerError, null, infoResponse.getMessage());

        return new FileDTO.Response()
                .setContent(retrieveResponse.getContent())
                .setContentLength(retrieveResponse.getContentLength())
                .setContentType(retrieveResponse.getContentType())
                .setContentDisposition(retrieveResponse.getContentDisposition())
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

    private byte[] readFile(String fileName) throws IOException {

        java.io.File file = new java.io.File(uploadDir + localFileDir + "/" + fileName);
        if (!file.exists())
            return new byte[0];

        return Files.readAllBytes(file.toPath());
    }

    private List<StorageDTO.Tag> readTag(String fileName) throws IOException {

        java.io.File file = new java.io.File(uploadDir + localFileDir + "/" + fileName);
        if (!file.exists())
            return null;

        byte[] readAllBytes = Files.readAllBytes(file.toPath());
        return objectMapper.readValue(readAllBytes, new TypeReference<List<StorageDTO.Tag>>() {
        });
    }

    private Map<String, String> readData(String fileName) throws IOException {

        java.io.File file = new java.io.File(uploadDir + localFileDir + "/" + fileName);
        if (!file.exists())
            return new HashMap<>();

        byte[] readAllBytes = Files.readAllBytes(file.toPath());
        return objectMapper.readValue(readAllBytes, new TypeReference<Map<String, String>>() {
        });
    }

    private void writeFile(String fileName, String content) throws IOException {

        java.io.File fileDir = new java.io.File(uploadDir + localFileDir);
        if (!fileDir.exists())
            fileDir.mkdirs();

        FileWriter writer = new FileWriter(uploadDir + localFileDir + "/" + fileName);
        writer.write(content);
        writer.close();
    }

    private void writeFile(String fileName, InputStream stream) throws IOException {

        byte[] buffer = new byte[stream.available()];
        stream.read(buffer);

        java.io.File fileDir = new java.io.File(uploadDir + localFileDir);
        if (!fileDir.exists())
            fileDir.mkdirs();

        java.io.File targetFile = new java.io.File(uploadDir + localFileDir + "/" + fileName);
        OutputStream outStream = new FileOutputStream(targetFile);
        outStream.write(buffer);
    }

    private String generateFileKey() {

        String saltChars = "-abcdefghijklmnopqrstuvwxyz1234567890";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 36) {
            int index = (int) (rnd.nextFloat() * saltChars.length());
            salt.append(saltChars.charAt(index));
        }
        return salt.toString();
    }

    private String storeFileInApp(@NotNull MultipartFile file, String tags) throws IOException {

        String fileKey = generateFileKey();
        while (fileDAO.findByFileKey(fileKey).isPresent())
            fileKey = generateFileKey();

        writeFile(fileKey, file.getInputStream());
        if (tags != null)
            writeFile(fileKey + ".tag", tags);
        writeFile(fileKey + ".data", "{\"" + file.getOriginalFilename() + "\":\"" + file.getContentType() + "\"}");

        return fileKey;
    }

    private StorageDTO.RetrieveResponseInApp retrieveFileInApp(String key) throws IOException {

        byte[] content = readFile(key);
        List<StorageDTO.Tag> tags = readTag(key + ".tag");
        Map<String, String> data = readData(key + ".data");

        StorageDTO.RetrieveResponseInApp retrieveResponseInApp = new StorageDTO.RetrieveResponseInApp();
        retrieveResponseInApp.
                setTagsResponse(tags).
                setContent(content).
                setContentLength((long) content.length).
                setContentType(MediaType.parseMediaType(data.values().iterator().next())).
                setContentDisposition(ContentDisposition.parse("attachment; filename=" + data.keySet().iterator().next()));

        return retrieveResponseInApp;
    }
}
