package com.nicico.sales.web.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequiredArgsConstructor
@RequestMapping("/tozinSales")
public class TozinSalesFormController {
	private final OAuth2AuthorizedClientService authorizedClientService;

	@Value("${nicico.rest-api.url}")
	private String restApiUrl;

	@RequestMapping("/showForm")
	public String showTozinSales() {
		return "base/tozinSales";
	}

	@RequestMapping(value = {"/showTransport2Plants/{date}"})
	public String showTransport2Plants(HttpServletRequest req, @PathVariable String date, @RequestParam("Authorization") String auth) {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", auth);
		HttpEntity<String> request = new HttpEntity<String>(headers);

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> modelMapFromRest = restTemplate.exchange(restApiUrl + "/api/tozinSales/showTransport2Plants/" + date, HttpMethod.GET, request, String.class);

		String out = modelMapFromRest.getBody();
		req.setAttribute("out", out);
		return "base/tozinSalesTransport2Plants";
	}

	@RequestMapping("/print/{type}/{date}")
	public ResponseEntity<?> print(Authentication authentication, @PathVariable String type, @PathVariable String date) {
		String token = "";
		if (authentication instanceof OAuth2AuthenticationToken) {
			OAuth2AuthorizedClient client = authorizedClientService
					.loadAuthorizedClient(
							((OAuth2AuthenticationToken) authentication).getAuthorizedClientRegistrationId(),
							authentication.getName());
			token = client.getAccessToken().getTokenValue();
		}

		RestTemplate restTemplate = new RestTemplate();
		restTemplate.getMessageConverters().add(new ByteArrayHttpMessageConverter());

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer " + token);

		HttpEntity<String> entity = new HttpEntity<String>(headers);

		if(type.equals("pdf"))
			return restTemplate.exchange(restApiUrl + "/api/tozinSales/print/pdf/"+date, HttpMethod.GET, entity, byte[].class);
		else if(type.equals("excel"))
			return restTemplate.exchange(restApiUrl + "/api/tozinSales/print/excel/"+date, HttpMethod.GET, entity, byte[].class);
		else if(type.equals("html"))
			return restTemplate.exchange(restApiUrl + "/api/tozinSales/print/html/"+date, HttpMethod.GET, entity, byte[].class);
		else
			return null;
	}
}
