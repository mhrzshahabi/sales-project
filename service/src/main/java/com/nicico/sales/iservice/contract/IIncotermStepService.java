package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermStepDTO;

import java.util.List;

public interface IIncotermStepService {

    IncotermStepDTO.Info get(Long id);

    List<IncotermStepDTO.Info> getAll(List<Long> ids);

    List<IncotermStepDTO.Info> list();

    IncotermStepDTO.Info create(IncotermStepDTO.Create request);

    List<IncotermStepDTO.Info> createAll(List<IncotermStepDTO.Create> requests);

    IncotermStepDTO.Info update(IncotermStepDTO.Update request);

    IncotermStepDTO.Info update(Long id, IncotermStepDTO.Update request);

    List<IncotermStepDTO.Info> updateAll(List<IncotermStepDTO.Update> requests);

    List<IncotermStepDTO.Info> updateAll(List<Long> ids, List<IncotermStepDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermStepDTO.Delete request);

    TotalResponse<IncotermStepDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermStepDTO.Info> search(SearchDTO.SearchRq request);
}