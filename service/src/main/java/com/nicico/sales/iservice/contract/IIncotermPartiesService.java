package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermPartiesDTO;

import java.util.List;

public interface IIncotermPartiesService {

    IncotermPartiesDTO.Info get(Long id);

    List<IncotermPartiesDTO.Info> getAll(List<Long> ids);

    List<IncotermPartiesDTO.Info> list();

    IncotermPartiesDTO.Info create(IncotermPartiesDTO.Create request);

    List<IncotermPartiesDTO.Info> createAll(List<IncotermPartiesDTO.Create> requests);

    IncotermPartiesDTO.Info update(IncotermPartiesDTO.Update request);

    IncotermPartiesDTO.Info update(Long id, IncotermPartiesDTO.Update request);

    List<IncotermPartiesDTO.Info> updateAll(List<IncotermPartiesDTO.Update> requests);

    List<IncotermPartiesDTO.Info> updateAll(List<Long> ids, List<IncotermPartiesDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermPartiesDTO.Delete request);

    TotalResponse<IncotermPartiesDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermPartiesDTO.Info> search(SearchDTO.SearchRq request);
}
