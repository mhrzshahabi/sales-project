package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractContactDTO;

import java.util.List;

public interface IContractContactService {

    ContractContactDTO.Info get(Long id);

    List<ContractContactDTO.Info> getAll(List<Long> ids);

    List<ContractContactDTO.Info> list();

    ContractContactDTO.Info create(ContractContactDTO.Create request);

    List<ContractContactDTO.Info> createAll(List<ContractContactDTO.Create> requests);

    ContractContactDTO.Info update(ContractContactDTO.Update request);

    ContractContactDTO.Info update(Long id, ContractContactDTO.Update request);

    List<ContractContactDTO.Info> updateAll(List<ContractContactDTO.Update> requests);

    List<ContractContactDTO.Info> updateAll(List<Long> ids, List<ContractContactDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractContactDTO.Delete request);

    TotalResponse<ContractContactDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractContactDTO.Info> search(SearchDTO.SearchRq request);
}