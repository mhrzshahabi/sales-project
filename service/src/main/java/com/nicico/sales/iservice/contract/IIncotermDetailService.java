package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermDetailDTO;

import java.util.List;

public interface IIncotermDetailService {

    IncotermDetailDTO.Info get(Long id);

    List<IncotermDetailDTO.Info> getAll(List<Long> ids);

    List<IncotermDetailDTO.Info> list();

    IncotermDetailDTO.Info create(IncotermDetailDTO.Create request);

    List<IncotermDetailDTO.Info> createAll(List<IncotermDetailDTO.Create> requests);

    IncotermDetailDTO.Info update(IncotermDetailDTO.Update request);

    IncotermDetailDTO.Info update(Long id, IncotermDetailDTO.Update request);

    List<IncotermDetailDTO.Info> updateAll(List<IncotermDetailDTO.Update> requests);

    List<IncotermDetailDTO.Info> updateAll(List<Long> ids, List<IncotermDetailDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermDetailDTO.Delete request);

    TotalResponse<IncotermDetailDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermDetailDTO.Info> search(SearchDTO.SearchRq request);
}