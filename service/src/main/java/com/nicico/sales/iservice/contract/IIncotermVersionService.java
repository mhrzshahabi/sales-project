package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermVersionDTO;

import java.util.List;

public interface IIncotermVersionService {

    IncotermVersionDTO.Info get(Long id);

    List<IncotermVersionDTO.Info> getAll(List<Long> ids);

    List<IncotermVersionDTO.Info> list();

    IncotermVersionDTO.Info create(IncotermVersionDTO.Create request);

    List<IncotermVersionDTO.Info> createAll(List<IncotermVersionDTO.Create> requests);

    IncotermVersionDTO.Info update(IncotermVersionDTO.Update request);

    IncotermVersionDTO.Info update(Long id, IncotermVersionDTO.Update request);

    List<IncotermVersionDTO.Info> updateAll(List<IncotermVersionDTO.Update> requests);

    List<IncotermVersionDTO.Info> updateAll(List<Long> ids, List<IncotermVersionDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermVersionDTO.Delete request);

    TotalResponse<IncotermVersionDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermVersionDTO.Info> search(SearchDTO.SearchRq request);
}