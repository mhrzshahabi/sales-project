package com.nicico.sales.service;

import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IInvoiceNosaService;
import com.nicico.sales.utility.AuthenticationUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.*;

@RequiredArgsConstructor
@Service
public class InvoiceNosaService implements IInvoiceNosaService {

    private final AuthenticationUtil authenticationUtil;
    private final Gson gson;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INVOICE_SALES')")
    public TotalResponse<InvoiceNosaDTO.Info> search(NICICOCriteria criteria) {

        final UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(accountingAppUrl + "/rest/detail/getDetailGridFetch");
        if (criteria.getCriteria() != null) {
            uriComponentsBuilder.queryParam("operator", criteria.getOperator())
                    .queryParam("_constructor", "AdvancedCriteria")
                    .queryParam("criteria", "{\"fieldName\":\"childrenDigitCount\",\"operator\":\"equals\",\"value\":\"0\",\"_constructor\":\"AdvancedCriteria\"}");

            ((Collection<?>) criteria.getCriteria()).forEach(c -> uriComponentsBuilder.queryParam("criteria", c.toString()));
        }

        uriComponentsBuilder.queryParam("_operationType", "fetch")
                .queryParam("_startRow", criteria.get_startRow())
                .queryParam("_endRow", criteria.get_endRow())
                .queryParam("_sortBy", (criteria.get_sortBy() != null ? criteria.get_sortBy() : "code"));

        final HttpEntity<?> httpEntity = new HttpEntity<>(authenticationUtil.getApplicationJSONHttpHeaders());

        final ResponseEntity<String> response = new RestTemplate().exchange(uriComponentsBuilder.build(false).encode().toUri(), HttpMethod.GET, httpEntity, String.class);

        return gson.fromJson(response.getBody(), TotalResponse.class);
    }
}
