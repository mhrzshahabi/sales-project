package com.nicico.sales.iservice;

import com.nicico.sales.model.entities.base.myModel.WholeDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ICreateReportService {
    List<WholeDto> createReport(String date, String warehouse);
}
