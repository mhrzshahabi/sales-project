package com.nicico.sales.iservice;

import com.nicico.sales.dto.FileDTO;
import io.minio.errors.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public interface IFileService {

    List<FileDTO.FileMetaData> getAll(List<Long> ids);

    void createFiles(Long recordId, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws IOException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, InternalException, XmlParserException, InvalidBucketNameException, InsufficientDataException, ErrorResponseException, RegionConflictException;

    void updateFiles(Long recordId, String entityName, List<MultipartFile> files, List<FileDTO.FileData> fileData) throws IOException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, InternalException, XmlParserException, InvalidBucketNameException, InsufficientDataException, ErrorResponseException, RegionConflictException;

    String store(FileDTO.Request request) throws IOException, InvalidResponseException, RegionConflictException, InvalidKeyException, NoSuchAlgorithmException, ServerException, ErrorResponseException, XmlParserException, InvalidBucketNameException, InsufficientDataException, InternalException;

    FileDTO.Response retrieve(String key) throws IOException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, ErrorResponseException, XmlParserException, InvalidBucketNameException, InsufficientDataException, InternalException;

    List<FileDTO.FileMetaData> getFiles(Long recordId, String entityName);

    void delete(String key) throws IOException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, ErrorResponseException, XmlParserException, InvalidBucketNameException, InsufficientDataException, InternalException;

    void restore(String key) throws IOException, InvalidResponseException, InvalidKeyException, NoSuchAlgorithmException, ServerException, InternalException, XmlParserException, InvalidBucketNameException, InsufficientDataException, ErrorResponseException;
}
