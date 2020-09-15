package com.nicico.sales.iservice;

import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;

import java.util.List;

public interface IWeightInspectionService extends IGenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> {

    List<WeightInspectionDTO.InfoWithoutInspectionReport> getWeightValues(Long shipmentId, InspectionReportMilestone reportMilestone, List<Long> inventoryIds);

    WeightInspectionDTO.Info getWeightInventoryData(InspectionReportMilestone reportMilestone, Long inventoryId);
}
