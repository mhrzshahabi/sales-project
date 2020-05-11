package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccDepartmentDTO;
import com.nicico.sales.iservice.IAccDepartmentService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;


@RequiredArgsConstructor
@Service
public class AccDepartmentService implements IAccDepartmentService {

    private final ModelMapper modelMapper;
    private final OAuth2RestTemplate restTemplate;

    @Value("${nicico.apps.accounting}")
    private String accountingAppUrl;

    @Transactional(readOnly = true)
    @Override
    public TotalResponse<AccDepartmentDTO.Info> search(NICICOCriteria criteria) {

        /*ResponseEntity<AccountingTotalResponse> response = restTemplate.getForEntity(accountingAppUrl + "/rest/oa-user-department/oa-user-cansubmit-department/", AccountingTotalResponse.class);
        AccountingGridResponse accountingGridResponse = response.getBody().getResponse();*/

        GridResponse<AccDepartmentDTO.Info> gridResponseDepartment = new GridResponse<>();

        /*gridResponseDepartment.setData(modelMapper.map(accountingGridResponse.getData(), new TypeToken<List<AccDepartmentDTO.Info>>() {
        }.getType()));
        gridResponseDepartment.setStartRow(accountingGridResponse.getStartRow());
        gridResponseDepartment.setEndRow(accountingGridResponse.getEndRow());
        gridResponseDepartment.setTotalRows(accountingGridResponse.getTotalRows());
        gridResponseDepartment.setStatus(accountingGridResponse.getStatus());*/

        ArrayList<AccDepartmentDTO.Info> infos = new ArrayList<>();

        AccDepartmentDTO.Info info = new AccDepartmentDTO.Info();
        info.setId(1L);
        info.setDepartmentCode(40L);
        info.setDepartmentName("تهزان");

        AccDepartmentDTO.Info info1 = new AccDepartmentDTO.Info();
        info1.setId(11L);
        info1.setDepartmentCode(10L);
        info1.setDepartmentName("رفسنجان");

        AccDepartmentDTO.Info info2 = new AccDepartmentDTO.Info();
        info2.setId(8L);
        info2.setDepartmentCode(20L);
        info2.setDepartmentName("شهربابک");

        AccDepartmentDTO.Info info3 = new AccDepartmentDTO.Info();
        info3.setId(9L);
        info3.setDepartmentCode(30L);
        info3.setDepartmentName("سونگون");

        infos.add(info);
        infos.add(info1);
        infos.add(info2);
        infos.add(info3);

        gridResponseDepartment.setData(infos);

        gridResponseDepartment.setStartRow(0);
        gridResponseDepartment.setEndRow(4);
        gridResponseDepartment.setTotalRows(4);
        gridResponseDepartment.setStatus(0);

        return new TotalResponse<>(gridResponseDepartment);
    }

}
