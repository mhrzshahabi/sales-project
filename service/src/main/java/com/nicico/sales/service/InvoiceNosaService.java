package com.nicico.sales.service;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.dto.InvoiceSalesDTO;
import com.nicico.sales.iservice.IInvoiceNosaService;
import com.nicico.sales.iservice.IInvoiceSalesService;
import com.nicico.sales.model.entities.base.InvoiceNosa;
import com.nicico.sales.model.entities.base.InvoiceSales;
import com.nicico.sales.repository.InvoiceSalesDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@RequiredArgsConstructor
@Service
public class InvoiceNosaService implements IInvoiceNosaService {

    private final InvoiceSalesDAO invoiceSalesDAO;
    private final ModelMapper modelMapper;
    private final OAuth2RestTemplate restTemplate;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Autowired
    Gson gson;

    @Transactional(readOnly = true)
    @Override
    //    @PreAuthorize("hasAuthority('R_INVOICE_SALES')")
    public List<InvoiceNosaDTO.Info> list() {

        ResponseEntity<String> totalResponse = restTemplate.getForEntity("http://localhost:8090/accounting" + "/rest/detail/getDetailGridFetch", String.class);

        String body = totalResponse.getBody();
        ArrayList arrInput = (ArrayList) ((LinkedTreeMap) ((LinkedHashMap) gson.fromJson(body, new TypeToken<Map<Object, Object>>() {
        }.getType())).get("response")).get("data");

        List<InvoiceNosa> invoiceNosa = new ArrayList<>();

        for(int i=0; i<arrInput.size(); i++){
            invoiceNosa.add(gson.fromJson(gson.toJsonTree(arrInput.get(i)),InvoiceNosa.class));
        }
        return modelMapper.map(invoiceNosa, new TypeToken<List<InvoiceNosaDTO.Info>>() {}.getType());
        }

}
