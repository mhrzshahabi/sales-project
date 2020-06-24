package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermAspectDTO;

import java.util.List;

public interface IIncotermAspectService {

    IncotermAspectDTO.Info get(Long id);

    List<IncotermAspectDTO.Info> getAll(List<Long> ids);

    List<IncotermAspectDTO.Info> list();

    IncotermAspectDTO.Info create(IncotermAspectDTO.Create request);

    List<IncotermAspectDTO.Info> createAll(List<IncotermAspectDTO.Create> requests);

    IncotermAspectDTO.Info update(IncotermAspectDTO.Update request);

    IncotermAspectDTO.Info update(Long id, IncotermAspectDTO.Update request);

    List<IncotermAspectDTO.Info> updateAll(List<IncotermAspectDTO.Update> requests);

    List<IncotermAspectDTO.Info> updateAll(List<Long> ids, List<IncotermAspectDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermAspectDTO.Delete request);

    TotalResponse<IncotermAspectDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermAspectDTO.Info> search(SearchDTO.SearchRq request);
}