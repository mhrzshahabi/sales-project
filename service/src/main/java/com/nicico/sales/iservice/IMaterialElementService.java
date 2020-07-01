package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.MaterialElementDTO;

import java.util.List;

public interface IMaterialElementService {

    MaterialElementDTO.Info get(Long id);

    List<MaterialElementDTO.Info> getAll(List<Long> ids);

    List<MaterialElementDTO.Info> list();

    MaterialElementDTO.Info create(MaterialElementDTO.Create request);

    List<MaterialElementDTO.Info> createAll(List<MaterialElementDTO.Create> requests);

    MaterialElementDTO.Info update(MaterialElementDTO.Update request);

    MaterialElementDTO.Info update(Long id, MaterialElementDTO.Update request);

    List<MaterialElementDTO.Info> updateAll(List<MaterialElementDTO.Update> requests);

    List<MaterialElementDTO.Info> updateAll(List<Long> ids, List<MaterialElementDTO.Update> requests);

    void delete(Long id);

    void deleteAll(MaterialElementDTO.Delete request);

    TotalResponse<MaterialElementDTO.Info> search(NICICOCriteria request);

}
