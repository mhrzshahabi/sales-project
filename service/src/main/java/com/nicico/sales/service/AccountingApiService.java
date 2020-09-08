package com.nicico.sales.service;

import com.nicico.sales.iservice.IAccountingApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class AccountingApiService implements IAccountingApiService {

    @Value("${spring.application.name}")
    private String appName;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    private final OAuth2RestTemplate restTemplate;

    @Override
    public void sendDataParameter(MultiValueMap<String, String> requestParams) {
        final String url = accountingAppUrl + "/rest/system-parameter/addSystemParmeter/" + appName + "/فروش";
        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        final HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(requestParams, httpHeaders);

        final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        if (httpResponse.getStatusCode().equals(HttpStatus.CREATED)) {
            System.out.println(httpResponse.getBody());
        } else {
            throw new RuntimeException("Exception: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
        }
    }

    @Override
    public void getDetailCodeInfo(String detailCode) {
        final String url = accountingAppUrl + "/rest/detail/getDetailByCode";
        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);

        final Map<String, String> requestParam = new HashMap<>();
        requestParam.put("detailCode", detailCode);

        final HttpEntity<Map<String, String>> httpEntity = new HttpEntity<>(requestParam, httpHeaders);

        final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
            System.out.println(httpResponse.getBody());
        } else {
            throw new RuntimeException("Exception: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
        }
    }
}
