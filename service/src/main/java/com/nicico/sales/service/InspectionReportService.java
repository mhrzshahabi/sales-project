package com.nicico.sales.service;

import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.model.entities.base.InspectionReport;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

}
