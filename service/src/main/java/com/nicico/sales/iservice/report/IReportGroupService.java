package com.nicico.sales.iservice.report;


import com.nicico.sales.dto.report.ReportGroupDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.report.ReportGroup;

public interface IReportGroupService extends IGenericService<ReportGroup, Long, ReportGroupDTO.Create, ReportGroupDTO.Info, ReportGroupDTO.Update, ReportGroupDTO.Delete> {


}
