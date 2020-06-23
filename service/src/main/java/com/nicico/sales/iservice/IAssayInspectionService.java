package com.nicico.sales.iservice;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.model.entities.base.AssayInspection;

public interface IAssayInspectionService extends IGenericService<AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete> {

}
