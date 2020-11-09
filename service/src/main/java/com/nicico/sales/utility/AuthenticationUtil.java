package com.nicico.sales.utility;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Slf4j
@Component
public class AuthenticationUtil {

	public HttpHeaders getApplicationJSONHttpHeaders() {
		final OAuth2AuthenticationDetails oAuth2AuthenticationDetails = getOAuth2AuthenticationDetails();

		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(oAuth2AuthenticationDetails.getTokenValue());
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		return httpHeaders;
	}

	public HttpHeaders getApplicationFormURLEncodedHttpHeaders() {
		final OAuth2AuthenticationDetails oAuth2AuthenticationDetails = getOAuth2AuthenticationDetails();

		final HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(oAuth2AuthenticationDetails.getTokenValue());
		httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

		return httpHeaders;
	}

	private OAuth2AuthenticationDetails getOAuth2AuthenticationDetails() {
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		return (OAuth2AuthenticationDetails) authentication.getDetails();
	}
}
