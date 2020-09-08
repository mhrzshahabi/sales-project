package com.nicico.sales.iservice;

import org.springframework.util.MultiValueMap;

public interface IAccountingApiService {

    void sendDataParameter(MultiValueMap<String, String> requestParams);

    void getDetailCodeInfo(String detailCode);
}
