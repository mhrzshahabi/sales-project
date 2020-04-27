package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailValueDTO;

import java.util.List;

public interface IContractDetailValueService {

    ContractDetailValueDTO.Info get(Long id);

    List<ContractDetailValueDTO.Info> getAll(List<Long> ids);

    List<ContractDetailValueDTO.Info> list();

    ContractDetailValueDTO.Info create(ContractDetailValueDTO.Create request);

    List<ContractDetailValueDTO.Info> createAll(List<ContractDetailValueDTO.Create> requests);

    ContractDetailValueDTO.Info update(ContractDetailValueDTO.Update request);

    ContractDetailValueDTO.Info update(Long id, ContractDetailValueDTO.Update request);

    List<ContractDetailValueDTO.Info> updateAll(List<ContractDetailValueDTO.Update> requests);

    List<ContractDetailValueDTO.Info> updateAll(List<Long> ids, List<ContractDetailValueDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDetailValueDTO.Delete request);

    TotalResponse<ContractDetailValueDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailValueDTO.Info> search(SearchDTO.SearchRq request);
}