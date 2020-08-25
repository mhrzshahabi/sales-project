package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.model.entities.base.TozinLite;

import java.util.Set;

public interface ITozinLiteService {
    TotalResponse<TozinLite> search(NICICOCriteria criteria);

    Set<TozinLite> findAllByTozinIdIn(Set<String> tozinIdList);
}
