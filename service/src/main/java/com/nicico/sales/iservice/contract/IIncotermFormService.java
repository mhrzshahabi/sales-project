package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermFormDTO;

import java.util.List;

public interface IIncotermFormService {

    IncotermFormDTO.Info get(Long id);

    List<IncotermFormDTO.Info> getAll(List<Long> ids);

    List<IncotermFormDTO.Info> list();

    IncotermFormDTO.Info create(IncotermFormDTO.Create request);

    List<IncotermFormDTO.Info> createAll(List<IncotermFormDTO.Create> requests);

    IncotermFormDTO.Info update(IncotermFormDTO.Update request);

    IncotermFormDTO.Info update(Long id, IncotermFormDTO.Update request);

    List<IncotermFormDTO.Info> updateAll(List<IncotermFormDTO.Update> requests);

    List<IncotermFormDTO.Info> updateAll(List<Long> ids, List<IncotermFormDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermFormDTO.Delete request);

    TotalResponse<IncotermFormDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermFormDTO.Info> search(SearchDTO.SearchRq request);
}
