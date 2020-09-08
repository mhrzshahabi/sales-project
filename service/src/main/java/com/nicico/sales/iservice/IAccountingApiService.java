package com.nicico.sales.iservice;

import org.springframework.util.MultiValueMap;

import java.io.IOException;

public interface IAccountingApiService {

    void sendDataParameter(MultiValueMap<String, String> requestParams) throws IOException;
}
