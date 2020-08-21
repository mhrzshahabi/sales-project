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

@RequiredArgsConstructor
@Service
public class AssayInspectionService extends GenericService<AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete> implements IAssayInspectionService {

    @Override
    public List<AssayInspectionDTO.InfoWithoutInspectionReportAndInventory> getAssayValues(Long shipmentId, InspectionReportMilestone reportMilestone) {

        List<AssayInspection> assayInspections = ((AssayInspectionDAO) repository).findAllByShipmentId(shipmentId);
        if (assayInspections.size() == 0)
            throw new NotFoundException(AssayInspection.class);

        switch (reportMilestone.getId()) {

            case 1:
                AssayInspection sourceInspection = assayInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Source).findFirst().orElseThrow(() -> new NotFoundException(AssayInspection.class));
                return modelMapper.map(sourceInspection, new TypeToken<List<AssayInspectionDTO.InfoWithoutInspectionReportAndInventory>>() {
                }.getType());
            case 2:
                AssayInspection destinationInspection = assayInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Destination).findFirst().orElseThrow(() -> new NotFoundException(AssayInspection.class));
                return modelMapper.map(destinationInspection, new TypeToken<List<AssayInspectionDTO.InfoWithoutInspectionReportAndInventory>>() {
                }.getType());
            case 3:
                AssayInspection umpireInspection = assayInspections.stream().filter(q -> q.getMileStone() == InspectionReportMilestone.Umpire).findFirst().orElseThrow(() -> new NotFoundException(AssayInspection.class));
                return modelMapper.map(umpireInspection, new TypeToken<List<AssayInspectionDTO.InfoWithoutInspectionReportAndInventory>>() {
                }.getType());
            default:
                throw new NotFoundException(AssayInspection.class);
        }
    }
}
