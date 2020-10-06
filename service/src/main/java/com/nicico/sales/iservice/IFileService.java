package com.nicico.sales.iservice;

import com.nicico.sales.dto.FileDTO;

public interface IFileService {

	String store(FileDTO.Request request);

	FileDTO.Response retrieve(String key);

	void delete(String key);
}
