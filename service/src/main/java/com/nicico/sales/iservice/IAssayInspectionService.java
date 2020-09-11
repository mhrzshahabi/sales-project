package com.nicico.sales.iservice;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;

import java.util.List;

public interface IAssayInspectionService extends IGenericService<AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete> {

    List<AssayInspectionDTO.InfoWithoutInspectionReport> getAssayValues(Long shipmentId, InspectionReportMilestone reportMilestone, List<Long> inventoryIds);
}
