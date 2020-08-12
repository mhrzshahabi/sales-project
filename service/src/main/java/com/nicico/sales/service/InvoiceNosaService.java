package com.nicico.sales.service;

import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.iservice.IInvoiceNosaService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class InvoiceNosaService implements IInvoiceNosaService {

    private final Gson gson;
    private final OAuth2RestTemplate restTemplate;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_INVOICE_SALES')")
    public TotalResponse<InvoiceNosaDTO.Info> search(NICICOCriteria criteria) {

        String queryCriteria = null;
        Map<String, String> uriVariables = new HashMap<>();
        if (criteria.getCriteria() != null) {
            queryCriteria = "operator=" + criteria.getOperator() + "&_constructor=AdvancedCriteria";
            queryCriteria = queryCriteria + "&criteria={0}";
            uriVariables.put("0", "{\"fieldName\":\"childrenDigitCount\",\"operator\":\"equals\",\"value\":\"0\",\"_constructor\":\"AdvancedCriteria\"}");
            Iterator criteriaIterator = ((LinkedList) criteria.getCriteria()).iterator();
            int key = 1;
            while (criteriaIterator.hasNext()) {
                uriVariables.put(String.valueOf(key), criteriaIterator.next().toString());
                queryCriteria = queryCriteria + "&criteria={" + key + "}";
                key++;
            }
        }
        ResponseEntity<String> response = restTemplate.getForEntity(accountingAppUrl + "/rest/detail/getDetailGridFetch?" +
                (queryCriteria != null ? queryCriteria + "&" : "") +
                "_operationType=fetch" +
                "&_startRow=" + criteria.get_startRow() +
                "&_endRow=" + criteria.get_endRow() +
                "&_sortBy=" + (criteria.get_sortBy() != null ? criteria.get_sortBy() : "code"), String.class, uriVariables);

        return gson.fromJson(response.getBody(), TotalResponse.class);
    }
}
