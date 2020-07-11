package com.nicico.sales.service;

import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class WeightInspectionService extends GenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> implements IWeightInspectionService {

    @Override
    public List<WeightInspectionDTO.Info> getWeightValues(List<Long> inventoryIds) {

        List<WeightInspection> weightInspection = ((WeightInspectionDAO) repository).findAllByInventoryIdIn(inventoryIds);
        return modelMapper.map(weightInspection, new TypeToken<List<WeightInspectionDTO.Info>>() {
        }.getType());
    }
}
