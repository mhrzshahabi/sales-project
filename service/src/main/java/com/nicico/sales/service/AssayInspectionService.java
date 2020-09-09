package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.repository.AssayInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class AssayInspectionService extends GenericService<AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete> implements IAssayInspectionService {

    @Override
    public List<AssayInspectionDTO.InfoWithoutInspectionReport> getAssayValues(Long shipmentId, InspectionReportMilestone reportMilestone, List<Long> inventoryIds) {

        List<AssayInspection> assayInspections = ((AssayInspectionDAO) repository).findAllByShipmentIdAndInventoryIdIn(shipmentId, inventoryIds);
        if (assayInspections.size() == 0)
            throw new NotFoundException(AssayInspection.class);

        if (!assayInspections.stream().map(AssayInspection::getInventoryId).collect(Collectors.toList()).containsAll(inventoryIds))
            throw new NotFoundException(AssayInspection.class);

        switch (reportMilestone.getId()) {

            case 1:
                List<AssayInspection> sourceInspections = assayInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Source).collect(Collectors.toList());
                if (sourceInspections.size() == 0)
                    throw new NotFoundException(AssayInspection.class);
                return modelMapper.map(sourceInspections, new TypeToken<List<AssayInspectionDTO.InfoWithoutInspectionReport>>() {
                }.getType());
            case 2:
                List<AssayInspection> destinationInspections = assayInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Destination).collect(Collectors.toList());
                if (destinationInspections.size() == 0)
                    throw new NotFoundException(AssayInspection.class);
                return modelMapper.map(destinationInspections, new TypeToken<List<AssayInspectionDTO.InfoWithoutInspectionReport>>() {
                }.getType());
            case 3:
                List<AssayInspection> umpireInspections = assayInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Umpire).collect(Collectors.toList());
                if (umpireInspections.size() == 0)
                    throw new NotFoundException(AssayInspection.class);
                return modelMapper.map(umpireInspections, new TypeToken<List<AssayInspectionDTO.InfoWithoutInspectionReport>>() {
                }.getType());
            default:
                throw new NotFoundException(AssayInspection.class);
        }
    }
}
