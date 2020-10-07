package com.nicico.sales.iservice;

import com.nicico.sales.dto.FileDTO;

import java.util.List;
import java.util.Map;

public interface IFileService {

	String store(FileDTO.Request request);

	FileDTO.Response retrieve(String key);

	void delete(String key);

	List<String> getByTags(Map<String, String> tags);
}
