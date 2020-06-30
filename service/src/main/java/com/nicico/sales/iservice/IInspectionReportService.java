package com.nicico.sales.iservice;

import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.model.entities.base.InspectionReport;

public interface IInspectionReportService extends IGenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> {

    InspectionReportDTO.Info createWeightInspec(InspectionReportDTO.Create request);
}
