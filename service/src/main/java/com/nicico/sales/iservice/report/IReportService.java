package com.nicico.sales.iservice.report;

import com.nicico.sales.dto.report.ReportDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.report.Report;
import com.nicico.sales.model.enumeration.ReportSource;

import java.util.List;

public interface IReportService extends IGenericService<Report, Long, ReportDTO.Create, ReportDTO.Info, ReportDTO.Update, ReportDTO.Delete> {

    List<ReportDTO.SourceData> getSourceData(ReportSource reportSource);

}
