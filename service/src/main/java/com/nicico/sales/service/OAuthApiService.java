package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.copper.oauth.common.dto.OAPermissionDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IOAuthApiService;
import com.nicico.sales.utility.AuthenticationUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.Arrays;

@Slf4j
@Service
@RequiredArgsConstructor
public class OAuthApiService implements IOAuthApiService {

    private final AuthenticationUtil authenticationUtil;
    private final ObjectMapper objectMapper;
    private final ResourceBundleMessageSource messageSource;

    // ----------------------------------------------------------------------------------------------------------------

    @Value("${nicico.apps.oauth}")
    private String oauthAppUrl;
    @Value("${spring.application.name}")
    private String appId;

    // ----------------------------------------------------------------------------------------------------------------

    @Override
    public void deletePermission(String permissionKey) {

        final String url = oauthAppUrl + "/api/permissions/code/" + appId + "/" + permissionKey;
        final HttpEntity<String> httpEntity = new HttpEntity<>(authenticationUtil.getApplicationJSONHttpHeaders());
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
        final HttpEntity<OAPermissionDTO.Create> httpEntity = new HttpEntity<>(request, authenticationUtil.getApplicationJSONHttpHeaders());
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
                    throw new SalesException2(ErrorType.InternalServerError, null, e.getMessage());
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
