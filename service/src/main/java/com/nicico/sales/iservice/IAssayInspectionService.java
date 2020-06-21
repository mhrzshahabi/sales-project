package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.model.entities.base.AssayInspection;

import java.util.List;

public interface IAssayInspectionService extends IGenericService <AssayInspection, Long, AssayInspectionDTO.Create, AssayInspectionDTO.Info, AssayInspectionDTO.Update, AssayInspectionDTO.Delete>{

    /*AssayInspectionDTO.Info get(Long id);

    List<AssayInspectionDTO.Info> list();

    AssayInspectionDTO.Info create(AssayInspectionDTO.Create request);

    AssayInspectionDTO.Info update(Long id, AssayInspectionDTO.Update request);

    void delete(Long id);

    void deleteAll(AssayInspectionDTO.Delete request);

    TotalResponse<AssayInspectionDTO.Info> search(NICICOCriteria criteria);*/

}
