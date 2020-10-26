package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.oauth.common.dto.OAPermissionDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IOAuthApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;

@Slf4j
@Service
@RequiredArgsConstructor
public class OAuthApiService implements IOAuthApiService {

    private final ObjectMapper objectMapper;
    private final ResourceBundleMessageSource messageSource;

    // ----------------------------------------------------------------------------------------------------------------

    @Value("${nicico.apps.oauth}")
    private String oauthAppUrl;
    @Value("${spring.application.name}")
    private String appId;

    // ----------------------------------------------------------------------------------------------------------------

    private HttpHeaders getApplicationJSONHttpHeaders() {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        final OAuth2AuthenticationDetails oAuth2AuthenticationDetails = (OAuth2AuthenticationDetails) authentication.getDetails();

        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(oAuth2AuthenticationDetails.getTokenValue());
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        return httpHeaders;
    }

    // ----------------------------------------------------------------------------------------------------------------

    @Override
    public void deletePermission(String permissionKey) {

        final String url = oauthAppUrl + "/api/permissions/" + appId + "/" + permissionKey;
        final HttpEntity<String> httpEntity = new HttpEntity<>(getApplicationJSONHttpHeaders());
        ResponseEntity<String> httpResponse;
        try {
            httpResponse = new RestTemplate().exchange(url, HttpMethod.DELETE, httpEntity, String.class);
        } catch (Exception e) {

            throw new SalesException2(e, ErrorType.Unknown, null, messageSource.getMessage("exception.delete-permission", null, LocaleContextHolder.getLocale()));
        }

        if (httpResponse.getStatusCode().equals(HttpStatus.OK))
            return;

        final String message = "OAuthApiService.deletePermission Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
        log.error(message);
        throw new SalesException2(ErrorType.BadRequest, null, message);
    }

    @Override
    public OAPermissionDTO.Info createPermission(OAPermissionDTO.Create request) {

        request.setAppId(appId);
        final String url = oauthAppUrl + "/api/permissions";
        final HttpEntity<OAPermissionDTO.Create> httpEntity = new HttpEntity<>(request, getApplicationJSONHttpHeaders());
        ResponseEntity<String> httpResponse;
        try {
            httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
        } catch (Exception e) {

            throw new SalesException2(e, ErrorType.Unknown, null, messageSource.getMessage("exception.add-permission", null, LocaleContextHolder.getLocale()));
        }

        if (httpResponse.getStatusCode().equals(HttpStatus.OK) || httpResponse.getStatusCode().equals(HttpStatus.CREATED)) {
            if (!StringUtils.isEmpty(httpResponse.getBody())) {
                try {
                    return objectMapper.readValue(httpResponse.getBody(), OAPermissionDTO.Info.class);
                } catch (IOException e) {
                    final String message = "OAuthApiService.createPermission Error: [" + Arrays.toString(e.getStackTrace()) + "]";
                    log.error(message);
                    throw new SalesException2(ErrorType.InternalServerError, null, message);
                }
            }
        } else {
            final String message = "OAuthApiService.createPermission Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
            log.error(message);
            throw new SalesException2(ErrorType.BadRequest, null, message);
        }

        return new OAPermissionDTO.Info();
    }
}
