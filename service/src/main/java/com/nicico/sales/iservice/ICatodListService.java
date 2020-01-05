package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.CatodListDTO;

import java.util.List;

public interface ICatodListService {

    CatodListDTO.Info get(Long id);

    List<CatodListDTO.Info> list();

    TotalResponse<CatodListDTO.Info> search(NICICOCriteria criteria);

    SearchDTO.SearchRs<CatodListDTO.Info> search(SearchDTO.SearchRq request);
}
