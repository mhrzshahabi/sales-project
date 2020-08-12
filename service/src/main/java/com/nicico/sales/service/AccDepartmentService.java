package com.nicico.sales.service;

import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccDepartmentDTO;
import com.nicico.sales.iservice.IAccDepartmentService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.*;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class AccDepartmentService implements IAccDepartmentService {

    private final Gson gson;
    private final OAuth2RestTemplate restTemplate;
    protected ResourceBundleMessageSource messageSource;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional(readOnly = true)
    @Override
    public TotalResponse<AccDepartmentDTO.Info> search(NICICOCriteria criteria) {

        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);

        HttpEntity entity = new HttpEntity(headers);

        ResponseEntity<String> response = restTemplate.exchange(accountingAppUrl + "/rest/oa-user-department/oa-user-cansubmit-department/", HttpMethod.GET, entity, String.class);
        return gson.fromJson(response.getBody(), TotalResponse.class);
    }
}
