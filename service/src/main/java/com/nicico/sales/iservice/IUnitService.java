package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.UnitDTO;

import java.util.List;

public interface IUnitService {

    UnitDTO.Info get(Long id);

    List<UnitDTO.Info> list();

    UnitDTO.Info create(UnitDTO.Create request);

    UnitDTO.Info update(Long id, UnitDTO.Update request);

    void delete(Long id);

    void delete(UnitDTO.Delete request);

    SearchDTO.SearchRs<UnitDTO.Info> search(SearchDTO.SearchRq request);

    TotalResponse<UnitDTO.Info> search(NICICOCriteria criteria);
}
