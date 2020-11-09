package com.nicico.sales.service;

import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.iservice.IAccDepartmentService;
import com.nicico.sales.utility.AuthenticationUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.*;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

@RequiredArgsConstructor
@Service
public class AccDepartmentService implements IAccDepartmentService {

    private final AuthenticationUtil authenticationUtil;
    private final Gson gson;
    protected ResourceBundleMessageSource messageSource;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional(readOnly = true)
    @Override
    public TotalResponse<AccountingDTO.DepartmentInfo> search(NICICOCriteria criteria) {
        HttpEntity<?> entity = new HttpEntity(authenticationUtil.getApplicationJSONHttpHeaders());

        ResponseEntity<String> response = new RestTemplate().exchange(accountingAppUrl + "/rest/oa-user-department/oa-user-cansubmit-department/", HttpMethod.GET, entity, String.class);
        return gson.fromJson(response.getBody(), TotalResponse.class);
    }
}
