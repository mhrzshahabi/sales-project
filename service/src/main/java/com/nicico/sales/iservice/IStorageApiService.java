package com.nicico.sales.iservice;

import com.nicico.sales.dto.StorageDTO;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

public interface IStorageApiService {

	StorageDTO.StoreResponse store(MultipartFile file, String tags);

	StorageDTO.RetrieveResponse retrieve(String key);

	StorageDTO.InfoResponse info(String key);

	StorageDTO active(String key);

	StorageDTO deactive(String key);

	StorageDTO.TagResponse getTags(String key);

	StorageDTO.TagResponse setTags(String key, String tags);

	StorageDTO.SearchResponse search(String tags);
}
