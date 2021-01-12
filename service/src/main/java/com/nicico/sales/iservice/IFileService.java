package com.nicico.sales.iservice;

import com.nicico.sales.dto.FileDTO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface IFileService {

    List<FileDTO.FileMetaData> getAll(List<Long> ids);

    void createFiles(Long recordId, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws IOException;

    void updateFiles(Long recordId, String entityName, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws IOException;

    String store(FileDTO.Request request) throws IOException;

    FileDTO.Response retrieve(String key) throws IOException;

    List<FileDTO.FileMetaData> getFiles(Long recordId, String entityName);

    List<FileDTO.FileMetaData> getFiles(String entityName);

    void delete(String key);

    void restore(String key);
}
