package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.TozinDTO;

import java.util.List;

public interface ITozinService {

    TotalResponse<TozinDTO.Info> searchTozin(NICICOCriteria criteria);

    TotalResponse<TozinDTO.Info> searchTozinOnTheWay(NICICOCriteria criteria, String tozin);

    List<Object[]> findTransport2Plants(String date, String plantId);

    String[] findPlants();
}
