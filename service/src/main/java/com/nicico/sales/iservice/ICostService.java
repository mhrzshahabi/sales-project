package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.CostDTO;

import java.util.List;

public interface ICostService {

    CostDTO.Info get(Long id);

    List<CostDTO.Info> list();

    CostDTO.Info create(CostDTO.Create request);

    CostDTO.Info update(Long id, CostDTO.Update request);

    void delete(Long id);

    void deleteAll(CostDTO.Delete request);

    TotalResponse<CostDTO.Info> search(NICICOCriteria criteria);
}
