package com.nicico.sales.iservice;

import com.nicico.sales.dto.AccountingDTO;
import org.springframework.util.MultiValueMap;

import java.util.List;
import java.util.Map;

public interface IAccountingApiService {

    String getDetailByCode(String detailCode);

    List<AccountingDTO.DocumentDetailRs> getDetailByName(MultiValueMap<String, String> requestParams);

//    String getDocumentInfo(String invoiceId);

    List<AccountingDTO.DepartmentInfo> getDepartments();

    void sendDataParameters(String systemNameFa, String systemNameEn, MultiValueMap<String, String> requestParams);

    Map<String, Object> sendInvoice(AccountingDTO.DocumentCreateRq request, List<Object> objects);

    Map<String, String> getInvoiceStatus(String systemName, List<String> requestParams);
}
