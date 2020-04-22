package com.nicico.sales.service;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.internal.LinkedTreeMap;
import com.nicico.sales.dto.AccDepartmentDTO;
import com.nicico.sales.iservice.IAccDepartmentService;
import com.nicico.sales.model.entities.base.AccDepartment;

import lombok.RequiredArgsConstructor;
import org.apache.commons.collections.map.HashedMap;
import org.apache.tomcat.util.json.JSONParser;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import springfox.documentation.spring.web.json.Json;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


@RequiredArgsConstructor
@Service
public class AccDepartmentService implements IAccDepartmentService {

    private final ModelMapper modelMapper;
    private final OAuth2RestTemplate restTemplate;
    private final Gson gson;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;


    @Override
    public List<AccDepartmentDTO.Info> list() {

        ResponseEntity<Object> response = restTemplate.getForEntity("http://localhost:8090/accounting" + "/rest/oa-user-department/oa-user-cansubmit-department/", Object.class);
//        ResponseEntity<Object> response = restTemplate.getForEntity( accountingAppUrl + "/rest/oa-user-department/oa-user-cansubmit-department/",Object.class);

        String res = gson.toJson(response.getBody());
        LinkedTreeMap linkedMapIn = (LinkedTreeMap) ((LinkedTreeMap) ((LinkedHashMap) gson.fromJson(res, new TypeToken<Map<Object, Object>>() {
        }.getType())).get("response")).get("data");

//        List<AccDepartment> accDepartments = new ArrayList<>();
//        for (int i=0; i<linkedMapIn.size(); i++){
////            accDepartments.add(linkedMapIn);
//        }

        List<AccDepartment> accDepartments = new ArrayList<>(linkedMapIn.values());

        return modelMapper.map(accDepartments, new TypeToken<List<AccDepartmentDTO.Info>>() {}.getType());
//        return null;
    }

}
