package com.nicico.sales.iservice.base2;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.base2.UnitDTO;

import java.util.List;

public interface IUnitService {

    UnitDTO.Info get(Long id);

    List<UnitDTO.Info> getAll(List<Long> ids);

    List<UnitDTO.Info> list();

    UnitDTO.Info create(UnitDTO.Create request);

    List<UnitDTO.Info> createAll(List<UnitDTO.Create> requests);

    UnitDTO.Info update(UnitDTO.Update request);

    UnitDTO.Info update(Long id, UnitDTO.Update request);

    List<UnitDTO.Info> updateAll(List<UnitDTO.Update> requests);

    List<UnitDTO.Info> updateAll(List<Long> ids, List<UnitDTO.Update> requests);

    void delete(Long id);

    void deleteAll(UnitDTO.Delete request);

    TotalResponse<UnitDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<UnitDTO.Info> search(SearchDTO.SearchRq request);
}
