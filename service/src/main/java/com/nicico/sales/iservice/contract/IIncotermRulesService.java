package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermRulesDTO;

import java.util.List;

public interface IIncotermRulesService {

    IncotermRulesDTO.Info get(Long id);

    List<IncotermRulesDTO.Info> getAll(List<Long> ids);

    List<IncotermRulesDTO.Info> list();

    IncotermRulesDTO.Info create(IncotermRulesDTO.Create request);

    List<IncotermRulesDTO.Info> createAll(List<IncotermRulesDTO.Create> requests);

    IncotermRulesDTO.Info update(IncotermRulesDTO.Update request);

    IncotermRulesDTO.Info update(Long id, IncotermRulesDTO.Update request);

    List<IncotermRulesDTO.Info> updateAll(List<IncotermRulesDTO.Update> requests);

    List<IncotermRulesDTO.Info> updateAll(List<Long> ids, List<IncotermRulesDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermRulesDTO.Delete request);

    TotalResponse<IncotermRulesDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermRulesDTO.Info> search(SearchDTO.SearchRq request);
}