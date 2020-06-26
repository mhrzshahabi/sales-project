package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.DepotDTO;

import java.util.List;

public interface IDepotService {

    DepotDTO.Info get(Long id);

    List<DepotDTO.Info> list();

    TotalResponse<DepotDTO.Info> search(NICICOCriteria request);
}
