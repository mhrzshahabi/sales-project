package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.TozinSalesDTO;

import java.util.List;

public interface ITozinSalesService {

    TotalResponse<TozinSalesDTO.Info> search(NICICOCriteria criteria);
}
