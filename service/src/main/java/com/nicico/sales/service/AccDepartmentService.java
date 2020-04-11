package com.nicico.sales.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.nicico.sales.dto.AccDepartmentDTO;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.iservice.IAccDepartmentService;
import com.nicico.sales.iservice.IInvoiceNosaService;
import com.nicico.sales.model.entities.base.AccDepartment;
import com.nicico.sales.model.entities.base.InvoiceNosa;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class AccDepartmentService implements IAccDepartmentService {

    private final ModelMapper modelMapper;
    private final OAuth2RestTemplate restTemplate;
//    private final ObjectMapper objectMapper;

//    @Value("${nicico.apps.accounting}")
//    private String accountingAppUrl;


    @Override
    public List<AccDepartmentDTO.Info> list() {
//        ResponseEntity<String> response = restTemplate.getForEntity(accountingAppUrl + "/rest/department/list", String.class);
        ResponseEntity<String> response = restTemplate.getForEntity("http://localhost:8090/accounting" + "/rest/oa-user-department/oa-user-cansubmit-department/",String.class);
//        return modelMapper.map(forEntity, new TypeToken<List<AccDepartmentDTO.Info>>() {}.getType());
        return null;
    }




//    @Transactional(readOnly = true)
//    @Override
//    //    @PreAuthorize("hasAuthority('R_INVOICE_SALES')")
//    public List<InvoiceNosaDTO.Info> list() {
//
//        ResponseEntity<String> response = restTemplate.getForEntity(accountingAppUrl + "/rest/detail/getDetailGridFetch?_operationType=fetch&_startRow=0&_endRow=500&_sortBy=code&_textMatchStyle=substring&\n" +
//                "                _componentId=isc_PickListMenu_0&_dataSource=isc_MyRestDataSource_3&isc_metaDataPrefix=_&isc_dataFormat=json", String.class);
//
//        String body = response.getBody();
//        ArrayList arrInput = (ArrayList) ((LinkedTreeMap) ((LinkedHashMap) gson.fromJson(body, new TypeToken<Map<Object, Object>>() {
//        }.getType())).get("response")).get("data");
//
//        List<InvoiceNosa> invoiceNosa = new ArrayList<>();
//
//        for(int i=0; i<arrInput.size(); i++){
//            invoiceNosa.add(gson.fromJson(gson.toJsonTree(arrInput.get(i)),InvoiceNosa.class));
//        }
//
//        return modelMapper.map(invoiceNosa, new TypeToken<List<InvoiceNosaDTO.Info>>() {}.getType());
//        }


}
