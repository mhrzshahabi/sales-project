package com.nicico.sales.controller;

import com.nicico.sales.dto.HRMDTO;
import com.nicico.sales.iservice.IHRMApiService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/api/hrm")
public class HRMRestController {

    private final IHRMApiService hrmApiService;

    @PostMapping(value = "/business-days")
    public ResponseEntity<HRMDTO.BusinessDaysInfo> getBusinessDays(@RequestBody HRMDTO.BusinessDaysRq request) {
        return new ResponseEntity<>(hrmApiService.getBusinessDays(request), HttpStatus.OK);
    }
}
