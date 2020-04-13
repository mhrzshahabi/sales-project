package com.nicico.sales.controller;

import com.nicico.copper.common.Loggable;
import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccDepartmentDTO;
import com.nicico.sales.dto.InvoiceNosaDTO;
import com.nicico.sales.iservice.IAccDepartmentService;
import com.nicico.sales.iservice.IInvoiceNosaService;
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
@RequestMapping(value = "/api/accDepartment")

public class AccDepartmentRestController {

    private final IAccDepartmentService iAccDepartmentService;

    @Loggable
    @GetMapping(value = "/list")
    public ResponseEntity<TotalResponse<AccDepartmentDTO.Info>> list() {

        GridResponse<AccDepartmentDTO.Info> gridResponseDep = new GridResponse<>();
        gridResponseDep.setData(iAccDepartmentService.list());
        TotalResponse<AccDepartmentDTO.Info> totalResponseDep = new TotalResponse<>(gridResponseDep);

        return new ResponseEntity<>(totalResponseDep, HttpStatus.OK);

    }

}
