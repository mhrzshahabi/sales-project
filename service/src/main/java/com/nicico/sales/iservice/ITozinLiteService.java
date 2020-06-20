package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.model.entities.base.TozinLite;

public interface ITozinLiteService {
    TotalResponse<TozinLite> search(NICICOCriteria criteria);
}