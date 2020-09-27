package com.nicico.sales.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.iservice.IAccountingApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.util.*;

@Slf4j
@RequiredArgsConstructor
@Service
public class AccountingApiService implements IAccountingApiService {

	@Value("${spring.application.name}")
	private String appName;

	@Value("${nicico.apps.accounting}")
	private String accountingAppUrl;

	// ---------------

	private final OAuth2RestTemplate restTemplate;
	private final ObjectMapper objectMapper;
	private final ModelMapper modelMapper;

	// ------------------------------

	@Override
	public String getDetailByCode(String detailCode) {
		final String url = accountingAppUrl + "/rest/detail/getDetailByCode";
		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		final Map<String, String> requestParam = new HashMap<>();
		requestParam.put("detailCode", detailCode);

		final HttpEntity<Map<String, String>> httpEntity = new HttpEntity<>(requestParam, httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				return httpResponse.getBody();
			}
		} else {
			log.error("AccountingApiService.GetDetailByCode Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		}

		return "";
	}

	@Override
	public List<AccountingDTO.DocumentDetailRs> getDetailByName(MultiValueMap<String, String> requestParams) {
		final String url = accountingAppUrl + "/rest/detail/getDetailGridFetch";
		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		final UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(url)
				.queryParams(requestParams);

		final HttpEntity<String> httpEntity = new HttpEntity<>(httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(uriComponentsBuilder.build(false).encode().toUri(), HttpMethod.GET, httpEntity, String.class);
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					final Map<String, Object> result = objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
					if (result.containsKey("response")) {
						final Map<String, Object> response = modelMapper.map(result.get("response"), new TypeToken<Map<String, Object>>() {
						}.getType());
						return response.containsKey("data") ? modelMapper.map(response.get("data"), new TypeToken<List<AccountingDTO.DocumentDetailRs>>() {
						}.getType()) : new ArrayList<>();
					} else
						return new ArrayList<>();
				} catch (IOException e) {
					log.error("AccountingApiService.GetDetailByName Error: [" + Arrays.toString(e.getStackTrace()) + "]");
				}
			}
		} else {
			log.error("AccountingApiService.GetDetailByName Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		}

		return new ArrayList<>();
	}

	/*@Override
	public String getDocumentInfo(String invoiceId) {
		final String url = accountingAppUrl + "/rest/system-document/document-Number/" + appName + "/" + invoiceId;
		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		final HttpEntity<String> httpEntity = new HttpEntity<>(httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.GET, httpEntity, String.class);
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				return httpResponse.getBody();
			}
		} else {
			log.error("AccountingApiService.getDocumentInfo Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		}

		return "";
	}*/

	@Override
	public List<AccountingDTO.DepartmentInfo> getDepartments() {
		final String url = accountingAppUrl + "/rest/document-mapper/baseDocValues";
		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		final HttpEntity<String> httpEntity = new HttpEntity<>(httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.GET, httpEntity, String.class);
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					final Map<String, Object> result = objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
					return result.containsKey("department") ? modelMapper.map(result.get("department"), new TypeReference<List<AccountingDTO.DepartmentInfo>>() {
					}.getType()) : new ArrayList<>();
				} catch (IOException e) {
					log.error("AccountingApiService.GetDepartments Error: [" + Arrays.toString(e.getStackTrace()) + "]");
				}
			}
		} else {
			log.error("AccountingApiService.GetDepartments Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		}

		return new ArrayList<>();
	}

	@Override
	public void sendDataParameters(String systemNameFa, String systemNameEn, MultiValueMap<String, String> requestParams) {
		final String url = accountingAppUrl + "/rest/system-parameter/addSystemParmeter/" + systemNameEn + "/" + systemNameFa;
		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		final HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(requestParams, httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
		if (httpResponse.getStatusCode().equals(HttpStatus.CREATED)) {
			log.info("AccountingApiService.SendDataParameters Info: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		} else {
			log.error("AccountingApiService.SendDataParameters Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		}
	}

	@Override
	public Map<String, Object> sendInvoice(AccountingDTO.DocumentCreateRq request, List<Object> objects) {
		final String url = accountingAppUrl + "/rest/document-mapper/docBuilder/" + appName;
		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		final List<Map<String, Object>> requestParamList = new ArrayList<>();
		objects.forEach(object -> {
			final Map<String, Object> requestParamMap = new HashMap<>();

			requestParamMap.put("documentDate", request.getDocumentDate());
			requestParamMap.put("department", request.getDepartment());
			requestParamMap.put("documentTitle", request.getDocumentTitle());

			switch (object.getClass().getSimpleName()) {
				case "ViewInternalInvoiceDocument":
					Arrays.stream(object.getClass().getDeclaredFields())
							.forEach(field -> {
								field.setAccessible(true);
								try {
									requestParamMap.put(field.getName(), field.get(object));
								} catch (IllegalAccessException e) {
									log.error("AccountingApiService.SendInvoice Error: [" + Arrays.toString(e.getStackTrace()) + "]");
								}
							});
					break;
			}

			requestParamList.add(requestParamMap);
		});

		final HttpEntity<List<Map<String, Object>>> httpEntity = new HttpEntity<>(requestParamList, httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					return objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
				} catch (IOException e) {
					log.error("AccountingApiService.SendInvoice Error: [" + Arrays.toString(e.getStackTrace()) + "]");
				}
			}
		} else {
			log.error("AccountingApiService.SendInvoice Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		}

		return new HashMap<>();
	}

	@Override
	public Map<String, String> getInvoiceStatus(String systemName, List<String> requestParams) {
		final String url = accountingAppUrl + "/rest/system-document/document-Number/" + systemName;
		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		final HttpEntity<List<String>> httpEntity = new HttpEntity<>(requestParams, httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					return objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
				} catch (IOException e) {
					log.error("AccountingApiService.GetInvoiceStatus Error: [" + Arrays.toString(e.getStackTrace()) + "]");
				}
			}
		} else {
			log.error("AccountingApiService.GetInvoiceStatus Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		}

		return new HashMap<>();
	}
}
