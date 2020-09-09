package com.nicico.sales.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.AccountingDepartmentDTO;
import com.nicico.sales.iservice.IAccountingApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;

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
    public String getDetailCode(String detailCode) {
        final String url = accountingAppUrl + "/rest/detail/getDetailByCode";
        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);

        final Map<String, String> requestParam = new HashMap<>();
        requestParam.put("detailCode", detailCode);

        final HttpEntity<Map<String, String>> httpEntity = new HttpEntity<>(requestParam, httpHeaders);

        final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
            if (StringUtils.isEmpty(httpResponse.getBody())) {
                return httpResponse.getBody();
            }
        } else {
            log.error("GetDetailCode Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
        }

        return null;
    }

    @Override
    public List<AccountingDepartmentDTO.Info> getDepartments() {
        final String url = accountingAppUrl + "/rest/document-mapper/baseDocValues";
        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);

        final HttpEntity<String> httpEntity = new HttpEntity<>(httpHeaders);

        final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
            if (StringUtils.isEmpty(httpResponse.getBody())) {
                try {
                    final Map<String, Object> result = objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
                    });
                    return modelMapper.map(result.get("department"), new TypeReference<List<AccountingDepartmentDTO.Info>>() {
                    }.getType());
                } catch (IOException e) {
                    log.error("GetDepartments Error: [" + Arrays.toString(e.getStackTrace()) + "]");
                }
            }
        } else {
            log.error("GetDepartments Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
        }

        return null;
    }

    @Override
    public void sendDataParameters(MultiValueMap<String, String> requestParams) {
        final String url = accountingAppUrl + "/rest/system-parameter/addSystemParmeter/" + appName + "/فروش";
        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        final HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(requestParams, httpHeaders);

        final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        if (httpResponse.getStatusCode().equals(HttpStatus.CREATED)) {
            System.out.println(httpResponse.getBody());
        } else {
            log.error("SendDataParameters Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
        }
    }

    @Override
    public Map<String, Object> sendInvoice(Integer department, List<Object> objects) {
        final String url = accountingAppUrl + "/rest/document-mapper/docBuilder/" + appName;
        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);

        final List<Map<String, Object>> requestParamList = new ArrayList<>();
        objects.forEach(object -> {
            Map<String, Object> requestParamMap = new HashMap<>();
            switch (object.getClass().getSimpleName()) {
                case "ViewInvoiceInternal":
                    requestParamMap.put("department", department);

                    Arrays.stream(object.getClass().getDeclaredFields())
                            .forEach(field -> {
                                field.setAccessible(true);
                                try {
                                    requestParamMap.put(field.getName(), field.get(object));
                                } catch (IllegalAccessException e) {
                                    log.error("SendInvoice Error: [" + Arrays.toString(e.getStackTrace()) + "]");
                                }
                            });
                    break;
            }

            requestParamList.add(requestParamMap);
        });

        final HttpEntity<List<Map<String, Object>>> httpEntity = new HttpEntity<>(requestParamList, httpHeaders);

        final ResponseEntity<String> httpResponse = restTemplate.exchange(url, HttpMethod.POST, httpEntity, String.class);
        if (httpResponse.getStatusCode().equals(HttpStatus.OK)) {
            if (StringUtils.isEmpty(httpResponse.getBody())) {
                try {
                    return objectMapper.readValue(httpResponse.getBody(), new TypeReference<Map<String, Object>>() {
                    });
                } catch (IOException e) {
                    log.error("SendInvoice Error: [" + Arrays.toString(e.getStackTrace()) + "]");
                }
            }
        } else {
            log.error("SendInvoice Error: [" + httpResponse.getStatusCode() + "]: " + httpResponse.getBody());
        }

        return null;
    }
}
