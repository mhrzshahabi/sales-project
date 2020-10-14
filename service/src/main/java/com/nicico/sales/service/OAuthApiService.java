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
@RequiredArgsConstructor
@Service
public class OAuthApiService implements IOAuthApiService {

    @Value("${nicico.apps.oauth}")
    private String oauthAppUrl;

    @Value("${spring.application.name}")
    private String appId;

    // ---------------

    private final ObjectMapper objectMapper;
    private final ResourceBundleMessageSource messageSource;

    // ------------------------------

    @Override
    public OAPermissionDTO.Info createPermission(OAPermissionDTO.Create request) {
        request.setAppId(appId);

        final String url = oauthAppUrl + "/api/permissions";

        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        final OAuth2AuthenticationDetails oAuth2AuthenticationDetails = (OAuth2AuthenticationDetails) authentication.getDetails();

        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setBearerAuth(oAuth2AuthenticationDetails.getTokenValue());
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        httpHeaders.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        final HttpEntity<OAPermissionDTO.Create> httpEntity = new HttpEntity<>(request, httpHeaders);

        ResponseEntity<String> httpResponse = null;
        try {
            httpResponse = new RestTemplate().exchange(url, HttpMethod.POST, httpEntity, String.class);
        } catch (Exception e) {

            throw new SalesException2(e, ErrorType.Unknown, null, messageSource.getMessage("exception.add-permission", null, LocaleContextHolder.getLocale()));
        }

        if (httpResponse != null && httpResponse.getStatusCode().equals(HttpStatus.OK)) {
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
            assert httpResponse != null;
            final String message = "OAuthApiService.createPermission Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody();
            log.error(message);
            throw new SalesException2(ErrorType.BadRequest, null, message);
        }

        return new OAPermissionDTO.Info();
    }
}
