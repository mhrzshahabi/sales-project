package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.TermDTO;

import java.util.List;

public interface ITermService {

    TermDTO.Info get(Long id);

    List<TermDTO.Info> getAll(List<Long> ids);

    List<TermDTO.Info> list();

    TermDTO.Info create(TermDTO.Create request);

    List<TermDTO.Info> createAll(List<TermDTO.Create> requests);

    TermDTO.Info update(TermDTO.Update request);

    TermDTO.Info update(Long id, TermDTO.Update request);

    List<TermDTO.Info> updateAll(List<TermDTO.Update> requests);

    List<TermDTO.Info> updateAll(List<Long> ids, List<TermDTO.Update> requests);

    void delete(Long id);

    void deleteAll(TermDTO.Delete request);

    TotalResponse<TermDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<TermDTO.Info> search(SearchDTO.SearchRq request);
}