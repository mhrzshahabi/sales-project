package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.model.entities.base.AssayInspection;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class AssayInspectionService extends GenericService<AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete> implements IAssayInspectionService {

}
