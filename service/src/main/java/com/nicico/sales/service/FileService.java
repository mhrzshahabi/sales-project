package com.nicico.sales.service;

import com.nicico.copper.core.service.minio.MinIODTO;
import com.nicico.copper.core.service.minio.MinIOService;
import com.nicico.sales.dto.FileDTO;
import com.nicico.sales.iservice.IFileService;
import com.nicico.sales.model.entities.base.File;
import com.nicico.sales.repository.FileDAO;
import io.minio.ListObjectsArgs;
import io.minio.MinioClient;
import io.minio.Result;
import io.minio.messages.Item;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class FileService implements IFileService {

	private final ModelMapper modelMapper;

	private final MinioClient minioClient;
	private final MinIOService minIOService;

	private final FileDAO fileDAO;

	@Override
	public String store(FileDTO.Request request) {
		try {
			final MinIODTO.Request fileRequest = modelMapper.map(request, MinIODTO.Request.class);
			final String fileKey = minIOService.store(fileRequest);

			final File file = new File()
					.setEntityName(request.getEntityName())
					.setRecordId(request.getRecordId())
					.setFileKey(fileKey);

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
	public void delete(String key) {
		try {
			minIOService.retrieve(key);
		} catch (Exception e) {
			log.error(Arrays.toString(e.getStackTrace()));
		}
	}

	@Override
	public List<String> getByTags(Map<String, String> tags) {
		Iterable<Result<Item>> results = minioClient.listObjects(ListObjectsArgs.builder().bucket("sales").build());
		return null;
	}
}
