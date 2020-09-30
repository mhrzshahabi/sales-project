package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.MaterialItemDTO;

import java.util.List;

public interface IMaterialItemService {
    void updateFromTozinView();


    MaterialItemDTO.Info get(Long id);

    List<MaterialItemDTO.Info> list();

    MaterialItemDTO.Info create(MaterialItemDTO.Create request);

    MaterialItemDTO.Info update(Long id, MaterialItemDTO.Update request);

    void delete(Long id);

    void deleteAll(MaterialItemDTO.Delete request);

    TotalResponse<MaterialItemDTO.Info> search(NICICOCriteria criteria);

    TotalResponse<MaterialItemDTO.InfoWithInventories> searchWithInventories(NICICOCriteria request);
}
