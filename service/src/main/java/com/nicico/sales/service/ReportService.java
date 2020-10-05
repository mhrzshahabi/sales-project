package com.nicico.sales.service;

import com.nicico.sales.dto.report.ReportDTO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ReportService {

    @Transactional
    public List<ReportDTO.RestData> getAllRest() {


        return new ArrayList<>();
    }

}
