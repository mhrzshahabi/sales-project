package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccDepartmentDTO;
import com.nicico.sales.iservice.IAccDepartmentService;
import com.nicico.sales.utility.AccountingGridResponse;
import com.nicico.sales.utility.AccountingTotalResponse;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


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

        ResponseEntity<AccountingTotalResponse> response = restTemplate.getForEntity(accountingAppUrl + "/rest/oa-user-department/oa-user-cansubmit-department/", AccountingTotalResponse.class);

        AccountingGridResponse accountingGridResponse = response.getBody().getResponse();

        GridResponse<AccDepartmentDTO.Info> gridResponseDepartment = new GridResponse<>();

        gridResponseDepartment.setData(modelMapper.map(accountingGridResponse.getData(), new TypeToken<List<AccDepartmentDTO.Info>>() {
        }.getType()));
        gridResponseDepartment.setStartRow(accountingGridResponse.getStartRow());
        gridResponseDepartment.setEndRow(accountingGridResponse.getEndRow());
        gridResponseDepartment.setTotalRows(accountingGridResponse.getTotalRows());
        gridResponseDepartment.setStatus(accountingGridResponse.getStatus());

        return new TotalResponse<>(gridResponseDepartment);
    }

}
