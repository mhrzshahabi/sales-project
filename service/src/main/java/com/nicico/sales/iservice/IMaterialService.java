package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.MaterialDTO;

import java.util.List;

public interface IMaterialService {

    MaterialDTO.Info get(Long id);

    List<MaterialDTO.Info> list();

    MaterialDTO.Info create(MaterialDTO.Create request);

    MaterialDTO.Info update(Long id, MaterialDTO.Update request);

    void delete(Long id);

    void deleteAll(MaterialDTO.Delete request);

    TotalResponse<MaterialDTO.Info> search(NICICOCriteria criteria);
}
