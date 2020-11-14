package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;

import java.util.List;

public interface IContractDetailTypeService {

    ContractDetailTypeDTO.Info get(Long id);

    List<ContractDetailTypeDTO.Info> getAll(List<Long> ids);

    List<ContractDetailTypeDTO.Info> list();

    ContractDetailTypeDTO.Info create(ContractDetailTypeDTO.Create request);

    List<ContractDetailTypeDTO.Info> createAll(List<ContractDetailTypeDTO.Create> requests);

    ContractDetailTypeDTO.Info update(ContractDetailTypeDTO.Update request);

    ContractDetailTypeDTO.Info update(Long id, ContractDetailTypeDTO.Update request);

    List<ContractDetailTypeDTO.Info> updateAll(List<ContractDetailTypeDTO.Update> requests);

    List<ContractDetailTypeDTO.Info> updateAll(List<Long> ids, List<ContractDetailTypeDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDetailTypeDTO.Delete request);

    TotalResponse<ContractDetailTypeDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailTypeDTO.Info> search(SearchDTO.SearchRq request);

    ContractDetailTypeDTO.Info activate(Long id);

    ContractDetailTypeDTO.Info deactivate(Long id);

}