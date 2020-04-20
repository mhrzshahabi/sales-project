package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermRuleDTO;

import java.util.List;

public interface IIncotermRuleService {

    IncotermRuleDTO.Info get(Long id);

    List<IncotermRuleDTO.Info> getAll(List<Long> ids);

    List<IncotermRuleDTO.Info> list();

    IncotermRuleDTO.Info create(IncotermRuleDTO.Create request);

    List<IncotermRuleDTO.Info> createAll(List<IncotermRuleDTO.Create> requests);

    IncotermRuleDTO.Info update(IncotermRuleDTO.Update request);

    IncotermRuleDTO.Info update(Long id, IncotermRuleDTO.Update request);

    List<IncotermRuleDTO.Info> updateAll(List<IncotermRuleDTO.Update> requests);

    List<IncotermRuleDTO.Info> updateAll(List<Long> ids, List<IncotermRuleDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermRuleDTO.Delete request);

    TotalResponse<IncotermRuleDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermRuleDTO.Info> search(SearchDTO.SearchRq request);
}