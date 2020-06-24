package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamValueDTO;

import java.util.List;

public interface IContractDetailTypeParamValueService {

    ContractDetailTypeParamValueDTO.Info get(Long id);

    List<ContractDetailTypeParamValueDTO.Info> getAll(List<Long> ids);

    List<ContractDetailTypeParamValueDTO.Info> list();

    ContractDetailTypeParamValueDTO.Info create(ContractDetailTypeParamValueDTO.Create request);

    List<ContractDetailTypeParamValueDTO.Info> createAll(List<ContractDetailTypeParamValueDTO.Create> requests);

    ContractDetailTypeParamValueDTO.Info update(ContractDetailTypeParamValueDTO.Update request);

    ContractDetailTypeParamValueDTO.Info update(Long id, ContractDetailTypeParamValueDTO.Update request);

    List<ContractDetailTypeParamValueDTO.Info> updateAll(List<ContractDetailTypeParamValueDTO.Update> requests);

    List<ContractDetailTypeParamValueDTO.Info> updateAll(List<Long> ids, List<ContractDetailTypeParamValueDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDetailTypeParamValueDTO.Delete request);

    TotalResponse<ContractDetailTypeParamValueDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailTypeParamValueDTO.Info> search(SearchDTO.SearchRq request);
}