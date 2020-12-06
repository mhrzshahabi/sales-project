package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermDTO;

import java.util.List;

public interface IIncotermService {

    IncotermDTO.Info get(Long id);

    List<IncotermDTO.Info> getAll(List<Long> ids);

    List<IncotermDTO.Info> list();

    TotalResponse<IncotermDTO.ViewForContract> getIncotermsForShowInContract(NICICOCriteria request);

    IncotermDTO.Info create(IncotermDTO.Create request);

    List<IncotermDTO.Info> createAll(List<IncotermDTO.Create> requests);

    IncotermDTO.Info update(IncotermDTO.Update request);

    IncotermDTO.Info update(Long id, IncotermDTO.Update request);

    List<IncotermDTO.Info> updateAll(List<IncotermDTO.Update> requests);

    List<IncotermDTO.Info> updateAll(List<Long> ids, List<IncotermDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermDTO.Delete request);

    TotalResponse<IncotermDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermDTO.Info> search(SearchDTO.SearchRq request);
}
