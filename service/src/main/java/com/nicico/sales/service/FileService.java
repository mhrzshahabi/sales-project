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

import java.util.*;

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
    @Transactional
    public String store(FileDTO.Request request) {
        try {
            final MinIODTO.Request fileRequest = modelMapper.map(request, MinIODTO.Request.class);
            final String fileKey = minIOService.store(fileRequest);

            final File file = new File()
                    .setEntityName(request.getEntityName())
                    .setRecordId(request.getRecordId())
                    .setFileKey(fileKey)
                    .setFileStatus(FileStatus.NORMAL);

            fileDAO.saveAndFlush(file);

            return fileKey;
        } catch (Exception e) {
            log.error(Arrays.toString(e.getStackTrace()));
        }

        return "";
    }

    @Override
    public FileDTO.Response retrieve(String key) {
        try {
            return modelMapper.map(minIOService.retrieve(key), FileDTO.Response.class);
        } catch (Exception e) {
            log.error(Arrays.toString(e.getStackTrace()));
        }

        return new FileDTO.Response();
    }

    @Override
    @Transactional(readOnly = true)
    public List<FileDTO.MetaData> getFiles(Long recordId, String entityName) {
        return modelMapper.map(fileDAO.findAllByRecordIdAndEntityName(recordId, entityName), new TypeToken<List<FileDTO.MetaData>>() {
        }.getType());
    }

    @Override
    @Transactional
    public void delete(String key) {

        final File file = fileDAO.findByFileKey(key)
                .orElseThrow(() -> new SalesException2(ErrorType.NotFound, "fileKey", "فایل مورد نظر یافت نشد."));

        boolean minIOIsOk = false;
        try {

            minIOService.delete(key);
            minIOIsOk = true;

            file.setFileStatus(FileStatus.DELETED);
            fileDAO.saveAndFlush(file);
        } catch (Exception e) {

            log.error(Arrays.toString(e.getStackTrace()));
            if (minIOIsOk)
                restore(key);
        }
    }

    @Override
    @Transactional
    public void restore(String key) {

        final File file = fileDAO.findByFileKey(key)
                .orElseThrow(() -> new SalesException2(ErrorType.NotFound, "fileKey", "فایل مورد نظر یافت نشد."));

        boolean minIOIsOk = false;
        try {

            Map<String, String> tags = this.minioClient.getObjectTags(GetObjectTagsArgs.builder().bucket(appId.toLowerCase()).object(key).build()).get();
            if (EFileStatus.DELETED.equals(EFileStatus.valueOf(tags.get("Status")))) {
                throw new NICICOException(IErrorCode.NotFound);
            } else if (EFileAccessLevel.SELF.equals(EFileAccessLevel.valueOf(tags.get("AccessLevel"))) && !Objects.equals(SecurityUtil.getUserId(), Long.valueOf(tags.get("UserId")))) {
                throw new NICICOException(IErrorCode.Forbidden);
            }

            tags.replace("Status", EFileStatus.NORMAL.getValue());
            tags.put("ModifiedBy", String.valueOf(SecurityUtil.getUserId()));
            tags.put("ModifiedDate", String.valueOf((new Date()).getTime()));
            this.minioClient.setObjectTags(SetObjectTagsArgs.builder().bucket(appId.toLowerCase()).object(key).tags(tags).build());
            minIOIsOk = true;

            file.setFileStatus(FileStatus.NORMAL);
            fileDAO.saveAndFlush(file);
        } catch (Exception e) {

            log.error(Arrays.toString(e.getStackTrace()));
            if (minIOIsOk)
                delete(key);
        }
    }
}
