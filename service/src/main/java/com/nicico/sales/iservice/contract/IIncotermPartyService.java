package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermPartyDTO;

import java.util.List;

public interface IIncotermPartyService {

    IncotermPartyDTO.Info get(Long id);

    List<IncotermPartyDTO.Info> getAll(List<Long> ids);

    List<IncotermPartyDTO.Info> list();

    IncotermPartyDTO.Info create(IncotermPartyDTO.Create request);

    List<IncotermPartyDTO.Info> createAll(List<IncotermPartyDTO.Create> requests);

    IncotermPartyDTO.Info update(IncotermPartyDTO.Update request);

    IncotermPartyDTO.Info update(Long id, IncotermPartyDTO.Update request);

    List<IncotermPartyDTO.Info> updateAll(List<IncotermPartyDTO.Update> requests);

    List<IncotermPartyDTO.Info> updateAll(List<Long> ids, List<IncotermPartyDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermPartyDTO.Delete request);

    TotalResponse<IncotermPartyDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermPartyDTO.Info> search(SearchDTO.SearchRq request);
}