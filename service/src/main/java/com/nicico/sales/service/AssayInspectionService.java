package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.repository.AssayInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class AssayInspectionService extends GenericService<AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete> implements IAssayInspectionService {

    @Override
    public List<AssayInspectionDTO.AssayData> getAssayValues(List<Long> inventoryIds, Boolean doIntegration) {

        List<AssayInspection> assayInspections = ((AssayInspectionDAO) repository).findAllByInventoryIdIn(inventoryIds);
        if (assayInspections.size() == 0)
            return new ArrayList<>();

        if (!doIntegration)
            return modelMapper.map(assayInspections, new TypeToken<List<AssayInspectionDTO.AssayData>>() {
            }.getType());

        Collection<AssayInspectionDTO.AssayData> groups = assayInspections.stream().collect(Collectors.groupingBy(AssayInspection::getMaterialElementId, Collectors.collectingAndThen(Collectors.toList(), q -> {

            BigDecimal averageValue = q.stream().map(AssayInspection::getValue).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(q.size()), RoundingMode.HALF_EVEN);
            AssayInspectionDTO.AssayData result = modelMapper.map(q.get(0), AssayInspectionDTO.AssayData.class);
            result.setValue(averageValue);
            result.setInventory(null);

            return result;
        }))).values();

        return new ArrayList<>(groups);
    }
}
