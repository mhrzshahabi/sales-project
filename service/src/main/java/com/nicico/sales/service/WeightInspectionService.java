package com.nicico.sales.service;

import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class WeightInspectionService extends GenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> implements IWeightInspectionService {

    @Override
    public List<WeightInspectionDTO.InfoWithoutInspectionReportAndInventory> getWeightValues(Long shipmentId, InspectionReportMilestone reportMilestone, List<Long> inventoryIds) {

        List<WeightInspection> weightInspections = ((WeightInspectionDAO) repository).findAllByShipmentIdAndInventoryIdIn(shipmentId, inventoryIds);
        if (weightInspections.size() == 0)
            throw new NotFoundException(WeightInspection.class);

        if (!weightInspections.stream().map(WeightInspection::getInventoryId).collect(Collectors.toList()).containsAll(inventoryIds))
            throw new NotFoundException(WeightInspection.class);

        switch (reportMilestone.getId()) {

            case 1:
                List<WeightInspection> sourceInspections = weightInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Source).collect(Collectors.toList());
                if (sourceInspections.size() == 0)
                    throw new NotFoundException(WeightInspection.class);
                return modelMapper.map(sourceInspections, new TypeToken<List<WeightInspectionDTO.InfoWithoutInspectionReportAndInventory>>() {
                }.getType());
            case 2:
                List<WeightInspection> destinationInspections = weightInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Destination).collect(Collectors.toList());
                if (destinationInspections.size() == 0)
                    throw new NotFoundException(WeightInspection.class);
                return modelMapper.map(destinationInspections, new TypeToken<List<WeightInspectionDTO.InfoWithoutInspectionReportAndInventory>>() {
                }.getType());
            case 3:
                List<WeightInspection> umpireInspections = weightInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Umpire).collect(Collectors.toList());
                if (umpireInspections.size() == 0)
                    throw new NotFoundException(WeightInspection.class);
                return modelMapper.map(umpireInspections, new TypeToken<List<WeightInspectionDTO.InfoWithoutInspectionReportAndInventory>>() {
                }.getType());
            default:
                throw new NotFoundException(WeightInspection.class);
        }
    }
}
