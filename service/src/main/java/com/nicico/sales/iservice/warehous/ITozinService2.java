package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.model.entities.warehouse.TozinTable;

import java.util.List;

public interface ITozinService2 {

    TozinTable get(Long id);

    TozinTable getByTozinId(String tozinIdString);

    List<TozinTable> getAllById(List<Long> ids);

    List<TozinTable> getAllByTozinCode(List<String> TozinCode);

    List<TozinTable> list();

    TotalResponse<TozinTable> search(NICICOCriteria request);

    SearchDTO.SearchRs<TozinTable> search(SearchDTO.SearchRq request);

}
