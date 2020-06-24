package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractTypeDTO;

import java.util.List;

public interface IContractTypeService {

    ContractTypeDTO.Info get(Long id);

    List<ContractTypeDTO.Info> getAll(List<Long> ids);

    List<ContractTypeDTO.Info> list();

    ContractTypeDTO.Info create(ContractTypeDTO.Create request);

    List<ContractTypeDTO.Info> createAll(List<ContractTypeDTO.Create> requests);

    ContractTypeDTO.Info update(ContractTypeDTO.Update request);

    ContractTypeDTO.Info update(Long id, ContractTypeDTO.Update request);

    List<ContractTypeDTO.Info> updateAll(List<ContractTypeDTO.Update> requests);

    List<ContractTypeDTO.Info> updateAll(List<Long> ids, List<ContractTypeDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractTypeDTO.Delete request);

    TotalResponse<ContractTypeDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractTypeDTO.Info> search(SearchDTO.SearchRq request);
}