package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.StorageDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IStorageApiService;
import com.nicico.sales.utility.AuthenticationUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;

@Slf4j
@RequiredArgsConstructor
@Service
public class StorageApiService implements IStorageApiService {

	@Value("${spring.application.name}")
	private String appId;

	@Value("${nicico.apps.storage}")
	private String storageUrl;

	// ---------------

	private final AuthenticationUtil authenticationUtil;
	private final ObjectMapper objectMapper;

	// ------------------------------

	@Override
	public StorageDTO.StoreResponse store(MultipartFile file, String tags) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase();

			final HttpHeaders httpHeaders = authenticationUtil.getMultiPartFormDataHttpHeaders();
			httpHeaders.set("app-name", appId);

			final ByteArrayResource fileResource = new ByteArrayResource(file.getBytes()) {
				@Override
				public String getFilename() {
					return file.getOriginalFilename();
				}
			};

			final MultiValueMap<String, Object> requestParam = new LinkedMultiValueMap<>();
			requestParam.put("file", Collections.singletonList(fileResource));
			requestParam.put("tags", Collections.singletonList(tags));

			final HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<>(requestParam, httpHeaders);
			final ResponseEntity<String> httpResponse;
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				if (!StringUtils.isEmpty(httpResponse.getBody())) {
					return objectMapper.readValue(httpResponse.getBody(), StorageDTO.StoreResponse.class);
				}
			} else {
				final String message = "StorageApiService.Store Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}

		return null;
	}

	@Override
	public StorageDTO.RetrieveResponse retrieve(String key) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase() + "/" + key;

			final HttpHeaders httpHeaders = authenticationUtil.getHttpHeaders();
			httpHeaders.set("app-name", appId);

			final HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

			final ResponseEntity<byte[]> httpResponse;

			httpResponse = new RestTemplate().exchange(url, HttpMethod.GET, httpEntity, byte[].class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				return new StorageDTO.RetrieveResponse()
						.setContent(httpResponse.getBody())
						.setContentLength(httpResponse.getHeaders().getContentLength())
						.setContentType(httpResponse.getHeaders().getContentType())
						.setContentDisposition(httpResponse.getHeaders().getContentDisposition());
			} else {
				final String message = "StorageApiService.Retrieve Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}
	}

	@Override
	public StorageDTO.InfoResponse info(String key) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase() + "/info/" + key;

			final HttpHeaders httpHeaders = authenticationUtil.getApplicationJSONHttpHeaders();
			httpHeaders.set("app-name", appId);

			final HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

			final ResponseEntity<String> httpResponse;

			httpResponse = new RestTemplate().exchange(url, HttpMethod.GET, httpEntity, String.class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				if (!StringUtils.isEmpty(httpResponse.getBody())) {
					return objectMapper.readValue(httpResponse.getBody(), StorageDTO.InfoResponse.class);
				}
			} else {
				final String message = "StorageApiService.Info Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}

		return null;
	}

	@Override
	public StorageDTO active(String key) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase() + "/active/" + key;

			final HttpHeaders httpHeaders = authenticationUtil.getApplicationJSONHttpHeaders();
			httpHeaders.set("app-name", appId);

			final HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

			final ResponseEntity<String> httpResponse;

			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				if (!StringUtils.isEmpty(httpResponse.getBody())) {
					return objectMapper.readValue(httpResponse.getBody(), StorageDTO.class);
				}
			} else {
				final String message = "StorageApiService.Active Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}

		return null;
	}

	@Override
	public StorageDTO deactive(String key) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase() + "/deactive/" + key;

			final HttpHeaders httpHeaders = authenticationUtil.getApplicationJSONHttpHeaders();
			httpHeaders.set("app-name", appId);

			final HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

			final ResponseEntity<String> httpResponse;

			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				if (!StringUtils.isEmpty(httpResponse.getBody())) {
					return objectMapper.readValue(httpResponse.getBody(), StorageDTO.class);
				}
			} else {
				final String message = "StorageApiService.Deactive Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}

		return null;
	}

	@Override
	public StorageDTO.TagResponse getTags(String key) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase() + "/tag/" + key;

			final HttpHeaders httpHeaders = authenticationUtil.getApplicationJSONHttpHeaders();
			httpHeaders.set("app-name", appId);

			final HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

			final ResponseEntity<String> httpResponse;

			httpResponse = new RestTemplate().exchange(url, HttpMethod.GET, httpEntity, String.class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				if (!StringUtils.isEmpty(httpResponse.getBody())) {
					return objectMapper.readValue(httpResponse.getBody(), StorageDTO.TagResponse.class);
				}
			} else {
				final String message = "StorageApiService.GetTags Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}

		return null;
	}

	@Override
	public StorageDTO.TagResponse setTags(String key, String tags) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase() + "/tag/" + key;

			final HttpHeaders httpHeaders = authenticationUtil.getApplicationJSONHttpHeaders();
			httpHeaders.set("app-name", appId);

			final HttpEntity<String> httpEntity = new HttpEntity<>(tags, httpHeaders);

			final ResponseEntity<String> httpResponse;

			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				if (!StringUtils.isEmpty(httpResponse.getBody())) {
					return objectMapper.readValue(httpResponse.getBody(), StorageDTO.TagResponse.class);
				}
			} else {
				final String message = "StorageApiService.SetTags Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}

		return null;
	}

	@Override
	public StorageDTO.SearchResponse search(String tags) {
		try {
			final String url = storageUrl + "/" + appId.toLowerCase() + "/search";

			final HttpHeaders httpHeaders = authenticationUtil.getApplicationJSONHttpHeaders();
			httpHeaders.set("app-name", appId);
			httpHeaders.set("tags", tags);

			final HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

			final ResponseEntity<String> httpResponse;

			httpResponse = new RestTemplate().exchange(url, HttpMethod.GET, httpEntity, String.class);
			if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
				if (!StringUtils.isEmpty(httpResponse.getBody())) {
					return objectMapper.readValue(httpResponse.getBody(), StorageDTO.SearchResponse.class);
				}
			} else {
				final String message = "StorageApiService.Search Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
				log.error(message);
				throw new SalesException2(ErrorType.BadRequest, null, message);
			}
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.InternalServerError, null, e.getMessage());
		}

		return null;
	}
}
