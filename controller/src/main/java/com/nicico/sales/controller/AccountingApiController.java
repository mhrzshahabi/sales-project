package com.nicico.sales.controller;

import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.iservice.IAccountingApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

    @GetMapping(value = "/documents/{invoiceId}")
    public ResponseEntity<String> getDocumentInfo(@PathVariable String invoiceId) {
        return new ResponseEntity<>(accountingApiService.getDocumentInfo(invoiceId), HttpStatus.OK);
    }

    @GetMapping(value = "/departments")
    public ResponseEntity<List<AccountingDTO.DepartmentInfo>> getAccountingDepartments() {
        return new ResponseEntity<>(accountingApiService.getDepartments(), HttpStatus.OK);
    }


}
