package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.IncotermFormsDTO;

import java.util.List;

public interface IIncotermFormsService {

    IncotermFormsDTO.Info get(Long id);

    List<IncotermFormsDTO.Info> getAll(List<Long> ids);

    List<IncotermFormsDTO.Info> list();

    IncotermFormsDTO.Info create(IncotermFormsDTO.Create request);

    List<IncotermFormsDTO.Info> createAll(List<IncotermFormsDTO.Create> requests);

    IncotermFormsDTO.Info update(IncotermFormsDTO.Update request);

    IncotermFormsDTO.Info update(Long id, IncotermFormsDTO.Update request);

    List<IncotermFormsDTO.Info> updateAll(List<IncotermFormsDTO.Update> requests);

    List<IncotermFormsDTO.Info> updateAll(List<Long> ids, List<IncotermFormsDTO.Update> requests);

    void delete(Long id);

    void deleteAll(IncotermFormsDTO.Delete request);

    TotalResponse<IncotermFormsDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<IncotermFormsDTO.Info> search(SearchDTO.SearchRq request);
}
