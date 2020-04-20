package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDTO;

import java.util.List;

public interface IContractService {

    ContractDTO.Info get(Long id);

    List<ContractDTO.Info> getAll(List<Long> ids);

    List<ContractDTO.Info> list();

    ContractDTO.Info create(ContractDTO.Create request);

    List<ContractDTO.Info> createAll(List<ContractDTO.Create> requests);

    ContractDTO.Info update(ContractDTO.Update request);

    ContractDTO.Info update(Long id, ContractDTO.Update request);

    List<ContractDTO.Info> updateAll(List<ContractDTO.Update> requests);

    List<ContractDTO.Info> updateAll(List<Long> ids, List<ContractDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDTO.Delete request);

    TotalResponse<ContractDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDTO.Info> search(SearchDTO.SearchRq request);
}