package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.repository.AssayInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class AssayInspectionService extends GenericService<AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete> implements IAssayInspectionService {

    @Override
    public List<AssayInspectionDTO.Info> getAssayValues(List<Long> inventoryIds) {

        List<AssayInspection> assayInspection = ((AssayInspectionDAO) repository).findAllByInventoryIdIn(inventoryIds);
        return modelMapper.map(assayInspection, new TypeToken<List<AssayInspectionDTO.Info>>() {
        }.getType());
    }
}
