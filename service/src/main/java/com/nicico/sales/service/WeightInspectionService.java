package com.nicico.sales.service;

import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

@RequiredArgsConstructor
@Service
public class WeightInspectionService extends GenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> implements IWeightInspectionService {

    @Override
    public WeightInspectionDTO.InfoWithoutInspectionReportAndInventory getWeightValues(Long shipmentId, Integer reportMilestone) {

        List<WeightInspection> weightInspections = ((WeightInspectionDAO) repository).findAllByShipmentId(shipmentId);
        if (weightInspections.size() == 0) return null;

        switch (reportMilestone) {

            case 1:
                WeightInspection sourceInspection = weightInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Source).findFirst().orElseThrow(() -> new NotFoundException(WeightInspection.class));
                return modelMapper.map(sourceInspection, WeightInspectionDTO.InfoWithoutInspectionReportAndInventory.class);
            case 2:
                WeightInspection destinationInspection = weightInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Destination).findFirst().orElseThrow(() -> new NotFoundException(WeightInspection.class));
                return modelMapper.map(destinationInspection, WeightInspectionDTO.InfoWithoutInspectionReportAndInventory.class);
            case 3:
                WeightInspection umpireInspection = weightInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Umpire).findFirst().orElseThrow(() -> new NotFoundException(WeightInspection.class));
                return modelMapper.map(umpireInspection, WeightInspectionDTO.InfoWithoutInspectionReportAndInventory.class);
            case 4:
                BigDecimal averageWeightGW = weightInspections.stream().map(WeightInspection::getWeightGW).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(weightInspections.size()), RoundingMode.HALF_EVEN);
                BigDecimal averageWeightND = weightInspections.stream().map(WeightInspection::getWeightND).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(weightInspections.size()), RoundingMode.HALF_EVEN);
                WeightInspectionDTO.InfoWithoutInspectionReportAndInventory averageInspection = modelMapper.map(weightInspections.get(0), WeightInspectionDTO.InfoWithoutInspectionReportAndInventory.class);
                averageInspection.setWeightGW(averageWeightGW);
                averageInspection.setWeightND(averageWeightND);
                averageInspection.setInventoryId(null);
                return averageInspection;
            default:
                throw new NotFoundException(WeightInspection.class);
        }
    }
}
