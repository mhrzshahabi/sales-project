package com.nicico.sales.iservice;

import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;

public interface IWeightInspectionService extends IGenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> {

    WeightInspectionDTO.InfoWithoutInspectionReportAndInventory getWeightValues(Long shipmentId, InspectionReportMilestone reportMilestone);
}
