package com.nicico.sales.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.dto.ErrorResponseDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.utility.AuthenticationUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.HttpClientErrorException;
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

	private final AuthenticationUtil authenticationUtil;
	private final ObjectMapper objectMapper;
	private final ModelMapper modelMapper;

	// ------------------------------

	@Override
	public String getDetailByCode(String detailCode) {
		final String url = accountingAppUrl + "/rest/detail/getDetailByCode";

		final Map<String, String> requestParam = new HashMap<>();
		requestParam.put("detailCode", detailCode);

		final HttpEntity<Map<String, String>> httpEntity = new HttpEntity<>(requestParam, authenticationUtil.getApplicationJSONHttpHeaders());

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

		final HttpEntity<?> httpEntity = new HttpEntity<>(authenticationUtil.getApplicationJSONHttpHeaders());

		ResponseEntity<String> httpResponse = null;
		try {
			httpResponse = new RestTemplate().exchange(uriComponentsBuilder.build(false).encode().toUri(), HttpMethod.GET, httpEntity, String.class);
		} catch (Exception e) {
			throwException(e);
		}

		if (httpResponse != null && httpResponse.getStatusCode().equals(HttpStatus.OK)) {
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
					throw new SalesException2(ErrorType.InternalServerError, null, e.getMessage());
				}
			}
		} else {
			final String message = "AccountingApiService.GetDetailByName Error: [" + (httpResponse != null ? httpResponse.getStatusCode() : "") + "]: " + (httpResponse != null ? httpResponse.getBody() : "");
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

		final HttpEntity<?> httpEntity = new HttpEntity<>(httpHeaders);

		final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.GET, httpEntity, String.class);
		if (httpResponse != null && httpResponse.getStatusCode().equals(HttpStatus.OK)) {
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

		final HttpEntity<?> httpEntity = new HttpEntity<>(authenticationUtil.getApplicationJSONHttpHeaders());

		ResponseEntity<String> httpResponse = null;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.GET, httpEntity, String.class);
		} catch (Exception e) {
			throwException(e);
		}

		if (httpResponse != null && httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					final Map<String, Object> result = objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
					return result.containsKey("department") ? modelMapper.map(result.get("department"), new TypeReference<List<AccountingDTO.DepartmentInfo>>() {
					}.getType()) : new ArrayList<>();
				} catch (IOException e) {
					final String message = "AccountingApiService.GetDepartments Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.InternalServerError, null, e.getMessage());
				}
			}
		} else {
			final String message = "AccountingApiService.GetDepartments Error: [" + (httpResponse != null ? httpResponse.getStatusCode() : "") + "]: " + (httpResponse != null ? httpResponse.getBody() : "");
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return new ArrayList<>();
	}

	@Override
	public void sendDataParameters(String systemNameEn, String systemNameFa, MultiValueMap<String, String> requestParams) {
		final String url = accountingAppUrl + "/rest/system-parameter/addSystemParmeter/" + systemNameEn + "/" + systemNameFa;

		final HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(requestParams, authenticationUtil.getApplicationFormURLEncodedHttpHeaders());

		ResponseEntity<String> httpResponse = null;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
		} catch (Exception e) {
			throwException(e);
		}

		if (httpResponse != null && httpResponse.getStatusCode().equals(HttpStatus.CREATED)) {
			log.info("AccountingApiService.SendDataParameters Info: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
		} else {
			final String message = "AccountingApiService.SendDataParameters Error: [" + (httpResponse != null ? httpResponse.getStatusCode() : "") + "]: " + (httpResponse != null ? httpResponse.getBody() : "");
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
				case "ViewForeignInvoiceDocument":
					break;
			}*/

			requestParamList.add(requestParamMap);
		});

		final HttpEntity<List<Map<String, Object>>> httpEntity = new HttpEntity<>(requestParamList, authenticationUtil.getApplicationJSONHttpHeaders());

		ResponseEntity<String> httpResponse = null;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
		} catch (Exception e) {
			throwException(e);
		}

		if (httpResponse != null && httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					return objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
					});
				} catch (IOException e) {
					final String message = "AccountingApiService.SendInvoice Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.InternalServerError, null, e.getMessage());
				}
			}
		} else {
			final String message = "AccountingApiService.SendInvoice Error: [" + (httpResponse != null ? httpResponse.getStatusCode() : "") + "]: " + (httpResponse != null ? httpResponse.getBody() : "");
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return new HashMap<>();
	}

	@Override
	public Map<String, String> getInvoiceStatus(String systemName, List<String> requestParams) {
		final String url = accountingAppUrl + "/rest/system-document/document-Number/" + systemName;

		final HttpEntity<List<?>> httpEntity = new HttpEntity<>(requestParams, authenticationUtil.getApplicationJSONHttpHeaders());

		ResponseEntity<String> httpResponse = null;
		try {
			httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
		} catch (Exception e) {
			throwException(e);
		}

		if (httpResponse != null && httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					return objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, String>>() {
					});
				} catch (IOException e) {
					final String message = "AccountingApiService.GetInvoiceStatus Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.InternalServerError, null, e.getMessage());
				}
			}
		} else {
			final String message = "AccountingApiService.GetInvoiceStatus Error: [" + (httpResponse != null ? httpResponse.getStatusCode() : "") + "]: " + (httpResponse != null ? httpResponse.getBody() : "");
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return new HashMap<>();
	}

	private void throwException(Exception e) {
		log.error("AccountingApiService.throwException Error: " + e.getMessage());

		if (e instanceof HttpClientErrorException) {
			try {
				final ErrorResponseDTO errorResponseDTO = objectMapper.readValue(((HttpClientErrorException) e).getResponseBodyAsString(), ErrorResponseDTO.class);

				if (!StringUtils.isEmpty(errorResponseDTO.getError())) {
					throw new SalesException2(e, ErrorType.BadRequest, null, errorResponseDTO.getError());
				} else if (!errorResponseDTO.getErrors().isEmpty()) {
					final ErrorResponseDTO.ErrorFieldDTO errorFieldDTO = (ErrorResponseDTO.ErrorFieldDTO) errorResponseDTO.getErrors().toArray()[0];
					throw new SalesException2(e, ErrorType.BadRequest, errorFieldDTO.getField(), errorFieldDTO.getMessage());
				} else {
					throw new SalesException2(ErrorType.BadRequest, null, e.getMessage());
				}
			} catch (IOException ioException) {
				final String message = "AccountingApiService.throwException Error: [" + Arrays.toString(e.getStackTrace()) + "]";
				log.error(message);
				throw new SalesException2(ErrorType.InternalServerError, null, e.getMessage());
			}
		}
	}
}
