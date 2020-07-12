package com.nicico.sales.service;

import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class WeightInspectionService extends GenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> implements IWeightInspectionService {

    @Override
    public WeightInspectionDTO.Info getWeightValues(Long inventoryId) {

        return modelMapper.map(((WeightInspectionDAO) repository).findByInventoryId(inventoryId), WeightInspectionDTO.Info.class);
    }
}
