package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.SalesTypeDTO;

import java.util.List;

public interface ISalesTypeService {

    List<SalesTypeDTO.Info> list();

    TotalResponse<SalesTypeDTO.Info> search(NICICOCriteria criteria);
}
