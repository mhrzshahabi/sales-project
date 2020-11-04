package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.HRMDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IHRMApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;

@Slf4j
@RequiredArgsConstructor
@Service
public class HRMApiService implements IHRMApiService {

	@Value("${nicico.apps.hrm}")
	private String hrmAppUrl;

	// ---------------

	private final ObjectMapper objectMapper;

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

	@Override
	public HRMDTO.BusinessDaysInfo getBusinessDays(HRMDTO.BusinessDaysRq request) {
		final String url = hrmAppUrl + "/api/officialCalendar/businessDays";

		final Calendar calendar = Calendar.getInstance();
		calendar.setTime(request.getDate());

		final UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(url)
				.queryParam("type", request.getType())
				.queryParam("day", calendar.get(Calendar.DAY_OF_MONTH))
				.queryParam("month", calendar.get(Calendar.MONTH) + 1)
				.queryParam("year", calendar.get(Calendar.YEAR));
		if (request.getBefore() != null)
			uriComponentsBuilder.queryParam("before", request.getBefore());
		if (request.getAfter() != null)
			uriComponentsBuilder.queryParam("after", request.getAfter());

		final HttpEntity<?> httpEntity = new HttpEntity<>(getApplicationJSONHttpHeaders());

		ResponseEntity<String> httpResponse = null;
		try {
			httpResponse = new RestTemplate().exchange(uriComponentsBuilder.build(false).encode().toUri(), HttpMethod.GET, httpEntity, String.class);
		} catch (Exception e) {
			throw new SalesException2(e, ErrorType.BadRequest, null, e.getMessage());
		}

		if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
			if (!StringUtils.isEmpty(httpResponse.getBody())) {
				try {
					return objectMapper.readValue(httpResponse.getBody(), HRMDTO.BusinessDaysInfo.class);
				} catch (IOException e) {
					final String message = "HRMApiService.getBusinessDays Error: [" + Arrays.toString(e.getStackTrace()) + "]";
					log.error(message);
					throw new SalesException2(ErrorType.InternalServerError, null, e.getMessage());
				}
			}
		} else {
			final String message = "HRMApiService.getBusinessDays Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
			log.error(message);
			throw new SalesException2(ErrorType.BadRequest, null, message);
		}

		return new HRMDTO.BusinessDaysInfo();
	}
}
