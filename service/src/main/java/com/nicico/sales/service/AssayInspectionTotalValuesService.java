package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionTotalValuesDTO;
import com.nicico.sales.iservice.IAssayInspectionTotalValuesService;
import com.nicico.sales.model.entities.base.AssayInspectionTotalValues;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AssayInspectionTotalValuesService extends GenericService<AssayInspectionTotalValues, Long, AssayInspectionTotalValuesDTO.Create, AssayInspectionTotalValuesDTO.Info, AssayInspectionTotalValuesDTO.Update, AssayInspectionTotalValuesDTO.Delete> implements IAssayInspectionTotalValuesService {

}