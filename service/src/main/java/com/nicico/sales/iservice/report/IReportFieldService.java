package com.nicico.sales.iservice.report;

import com.nicico.sales.dto.report.ReportFieldDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.report.ReportField;

public interface IReportFieldService extends IGenericService<ReportField, Long, ReportFieldDTO.Create, ReportFieldDTO.Info, ReportFieldDTO.Update, ReportFieldDTO.Delete> {

}
