package com.nicico.sales.iservice;

import com.nicico.sales.dto.FileDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IFileService {

	List<FileDTO.FileMetaData> getAll(List<Long> ids);

	void createFiles(Long recordId, List<MultipartFile> files, List<FileDTO.FileData> fileData);

	void updateFiles(Long recordId, String entityName, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws Exception;

	String store(FileDTO.Request request) throws Exception;

	FileDTO.Response retrieve(String key) throws Exception;

	List<FileDTO.FileMetaData> getFiles(Long recordId, String entityName);

	void delete(String key) throws Exception;

	void restore(String key) throws Exception;
}
