package com.nicico.sales.iservice;

import com.nicico.sales.dto.FileDTO;

import java.util.List;

public interface IFileService {

    String store(FileDTO.Request request);

    FileDTO.Response retrieve(String key);

    List<FileDTO.MetaData> getFiles(Long recordId, String entityName);

    void delete(String key);

    void restore(String key);
}
