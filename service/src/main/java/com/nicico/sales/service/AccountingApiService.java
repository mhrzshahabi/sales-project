package com.nicico.sales.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.util.*;

@Slf4j
@RequiredArgsConstructor
@Service
public class AccountingApiService implements IAccountingApiService {

	@Value("${nicico.apps.accounting}")
	private String accountingAppUrl;

	// ---------------

	private final ObjectMapper objectMapper;
	private final ModelMapper modelMapper;

	// ------------------------------

	public HttpHeaders getApplicationJSONHttpHeaders() {
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		final OAuth2AuthenticationDetails oAuth2AuthenticationDetails = (OAuth2AuthenticationDetails) authentication.getDetails();

		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(oAuth2AuthenticationDetails.getTokenValue());
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		return httpHeaders;
	}

	public HttpHeaders getApplicationFormURLEncodedHttpHeaders() {
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		final OAuth2AuthenticationDetails oAuth2AuthenticationDetails = (OAuth2AuthenticationDetails) authentication.getDetails();

		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(oAuth2AuthenticationDetails.getTokenValue());
		httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		return httpHeaders;
	}

	@Override
	public String getDetailByCode(String detailCode) {
		final String url = accountingAppUrl + "/rest/detail/getDetailByCode";

		final Map<String, String> requestParam = new HashMap<>();
		requestParam.put("detailCode", detailCode);

		final HttpEntity<Map<String, String>> httpEntity = new HttpEntity<>(requestParam, getApplicationJSONHttpHeaders());

		final ResponseEntity<String> httpResponse;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
		}
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				return httpResponse.getBody();
			}
		} else {
			final String message = "AccountingApiService.GetDetailByCode Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return "";
	}

	@Override
	public List<AccountingDTO.DocumentDetailRs> getDetailByName(MultiValueMap<String, String> requestParams) {
		final String url = accountingAppUrl + "/rest/detail/getDetailGridFetch";

		final UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(url)
				.queryParams(requestParams);

		final HttpEntity<String> httpEntity = new HttpEntity<>(getApplicationJSONHttpHeaders());

		final ResponseEntity<String> httpResponse;
		try {
			httpResponse = new RestTemplate().exchange(uriComponentsBuilder.build(false).encode().toUri(), HttpMethod.GET, httpEntity, String.class);
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
		}
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
					final String message = "AccountingApiService.GetDetailByName Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.BadRequest, null, message);
				}
			}
		} else {
			final String message = "AccountingApiService.GetDetailByName Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
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

		final HttpEntity<String> httpEntity = new HttpEntity<>(getApplicationJSONHttpHeaders());

		final ResponseEntity<String> httpResponse;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.GET, httpEntity, String.class);
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
		}
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					final Map<String, Object> result = objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
					return result.containsKey("department") ? modelMapper.map(result.get("department"), new TypeReference<List<AccountingDTO.DepartmentInfo>>() {
					}.getType()) : new ArrayList<>();
				} catch (IOException e) {
					final String message = "AccountingApiService.GetDepartments Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.BadRequest, null, message);
				}
			}
		} else {
			final String message = "AccountingApiService.GetDepartments Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return new ArrayList<>();
	}

	@Override
	public void sendDataParameters(String systemNameEn, String systemNameFa, MultiValueMap<String, String> requestParams) {
		final String url = accountingAppUrl + "/rest/system-parameter/addSystemParmeter/" + systemNameEn + "/" + systemNameFa;

		final HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(requestParams, getApplicationFormURLEncodedHttpHeaders());

		final ResponseEntity<String> httpResponse;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
		}
		if (httpResponse.getStatusCode().equals(HttpStatus.CREATED)) {
			log.info("AccountingApiService.SendDataParameters Info: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		} else {
			final String message = "AccountingApiService.SendDataParameters Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}
	}

	@Override
	public Map<String, Object> sendInvoice(String systemName, AccountingDTO.DocumentCreateRq request, List<Object> objects) {
		final String url = accountingAppUrl + "/rest/document-mapper/docBuilder/" + systemName;

		final List<Map<String, Object>> requestParamList = new ArrayList<>();
		objects.forEach(object -> {
			final Map<String, Object> requestParamMap = new HashMap<>();

			requestParamMap.put("documentDate", request.getDocumentDate());
			requestParamMap.put("department", request.getDepartment());
			requestParamMap.put("documentTitle", request.getDocumentTitle());

			Arrays.stream(object.getClass().getDeclaredFields())
					.forEach(field -> {
						field.setAccessible(true);
						try {
							requestParamMap.put(field.getName(), field.get(object));
						} catch (IllegalAccessException e) {
							log.error("AccountingApiService.SendInvoice Error: [" + Arrays.toString(e.getStackTrace()) + "]");
						}
					});

			/*switch (object.getClass().getSimpleName()) {
				case "ViewInternalInvoiceDocument":
					break;
				case "ViewCostInvoiceDocument":
					break;
			}*/

			requestParamList.add(requestParamMap);
		});

		final HttpEntity<List<Map<String, Object>>> httpEntity = new HttpEntity<>(requestParamList, getApplicationJSONHttpHeaders());

		final ResponseEntity<String> httpResponse;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
		}
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					return objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
				} catch (IOException e) {
					final String message = "AccountingApiService.SendInvoice Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.BadRequest, null, message);
				}
			}
		} else {
			final String message = "AccountingApiService.SendInvoice Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return new HashMap<>();
	}

	@Override
	public Map<String, String> getInvoiceStatus(String systemName, List<String> requestParams) {
		final String url = accountingAppUrl + "/rest/system-document/document-Number/" + systemName;

		final HttpEntity<List<String>> httpEntity = new HttpEntity<>(requestParams, getApplicationJSONHttpHeaders());

		final ResponseEntity<String> httpResponse;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
		}
		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					return objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
				} catch (IOException e) {
					final String message = "AccountingApiService.GetInvoiceStatus Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.BadRequest, null, message);
				}
			}
		} else {
			final String message = "AccountingApiService.GetInvoiceStatus Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return new HashMap<>();
	}
}
