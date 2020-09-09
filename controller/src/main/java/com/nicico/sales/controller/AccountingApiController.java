package com.nicico.sales.controller;

import com.nicico.sales.dto.AccountingDepartmentDTO;
import com.nicico.sales.iservice.IAccountingApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/accounting")
public class AccountingApiController {

    private final IAccountingApiService accountingApiService;

    // ------------------------------

    @GetMapping(value = "/departments")
    public ResponseEntity<List<AccountingDepartmentDTO.Info>> getAccountingDepartments() {
        return new ResponseEntity<>(accountingApiService.getDepartments(), HttpStatus.OK);
    }
}
