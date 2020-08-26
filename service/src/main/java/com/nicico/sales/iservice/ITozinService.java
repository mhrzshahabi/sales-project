package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.TozinDTO;
import com.nicico.sales.model.entities.base.Tozin;

import java.util.Set;

public interface ITozinService {

    TotalResponse<TozinDTO.Info> search(NICICOCriteria criteria);

    Set<Tozin> getAllByTozinIdIn(Set<String> tozinIdList);

}
