package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermContactDTO;

import java.util.List;

public interface IIncotermContactService {

    IncotermContactDTO.Info get(Long id);

    List<IncotermContactDTO.Info> getAll(List<Long> ids);

    List<IncotermContactDTO.Info> list();

    IncotermContactDTO.Info create(IncotermContactDTO.Create request);

    List<IncotermContactDTO.Info> createAll(List<IncotermContactDTO.Create> requests);

    IncotermContactDTO.Info update(IncotermContactDTO.Update request);

    IncotermContactDTO.Info update(Long id, IncotermContactDTO.Update request);

    List<IncotermContactDTO.Info> updateAll(List<IncotermContactDTO.Update> requests);

    List<IncotermContactDTO.Info> updateAll(List<Long> ids, List<IncotermContactDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermContactDTO.Delete request);

    TotalResponse<IncotermContactDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermContactDTO.Info> search(SearchDTO.SearchRq request);
}