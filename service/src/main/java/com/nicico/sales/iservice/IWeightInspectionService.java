package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.model.entities.base.WeightInspection;

import java.util.List;

public interface IWeightInspectionService extends IGenericService <WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete>{

    /*WeightInspectionDTO.Info get(Long id);

    List<WeightInspectionDTO.Info> list();

    WeightInspectionDTO.Info create(WeightInspectionDTO.Create request);

    WeightInspectionDTO.Info update(Long id, WeightInspectionDTO.Update request);

    void delete(Long id);

    void deleteAll(WeightInspectionDTO.Delete request);

    TotalResponse<WeightInspectionDTO.Info> search(NICICOCriteria criteria);*/

}
