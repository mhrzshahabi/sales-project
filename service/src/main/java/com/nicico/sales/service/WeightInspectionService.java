package com.nicico.sales.service;

import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class WeightInspectionService extends GenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> implements IWeightInspectionService {

    @Override
    public List<WeightInspectionDTO.WeightData> getWeightValues(List<Long> inventoryIds, Boolean doIntegration) {

        List<WeightInspection> weightInspections = ((WeightInspectionDAO) repository).findAllByInventoryId(inventoryIds);
        if (weightInspections.size() == 0)
            return new ArrayList<>();

        if (!doIntegration)
            return modelMapper.map(weightInspections, new TypeToken<List<WeightInspectionDTO.WeightData>>() {
            }.getType());

        BigDecimal averageWeightGW = weightInspections.stream().map(WeightInspection::getWeightGW).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(weightInspections.size()), RoundingMode.HALF_EVEN);
        BigDecimal averageWeightND = weightInspections.stream().map(WeightInspection::getWeightND).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(weightInspections.size()), RoundingMode.HALF_EVEN);
        WeightInspectionDTO.WeightData result = modelMapper.map(weightInspections.get(0), WeightInspectionDTO.WeightData.class);
        result.setWeightGW(averageWeightGW);
        result.setWeightND(averageWeightND);
        result.setInventory(null);

        return new ArrayList<WeightInspectionDTO.WeightData>() {{
            add(result);
        }};
    }
}
