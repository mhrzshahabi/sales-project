package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.model.entities.warehouse.Tozin2;
import com.nicico.sales.model.entities.warehouse.TozinId;

import java.util.List;

public interface ITozinService2 {

    Tozin2 get(TozinId id);

    Tozin2 getByTozinId(String tozinIdString);

    List<Tozin2> getAllById(List<TozinId> ids);

    List<Tozin2> getAllByTozinCode(List<String> TozinCode);

    List<Tozin2> list();

    TotalResponse<Tozin2> search(NICICOCriteria request);

    SearchDTO.SearchRs<Tozin2> search(SearchDTO.SearchRq request);
}
