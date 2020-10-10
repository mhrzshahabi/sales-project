package com.nicico.sales.service.report;

import com.nicico.sales.dto.report.ReportFieldDTO;
import com.nicico.sales.iservice.report.IReportFieldService;
import com.nicico.sales.model.entities.report.ReportField;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ReportFieldService extends GenericService<ReportField, Long, ReportFieldDTO.Create, ReportFieldDTO.Info, ReportFieldDTO.Update, ReportFieldDTO.Delete> implements IReportFieldService {

}
