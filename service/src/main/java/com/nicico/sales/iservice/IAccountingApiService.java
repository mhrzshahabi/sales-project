package com.nicico.sales.iservice;

import com.nicico.sales.dto.AccountingDepartmentDTO;
import org.springframework.util.MultiValueMap;

import java.util.List;
import java.util.Map;

public interface IAccountingApiService {

    String getDetailCode(String detailCode);

    List<AccountingDepartmentDTO.Info> getDepartments();

    void sendDataParameters(MultiValueMap<String, String> requestParams);

    Map<String, Object> sendInvoice(Integer department, List<Object> objects);
}
