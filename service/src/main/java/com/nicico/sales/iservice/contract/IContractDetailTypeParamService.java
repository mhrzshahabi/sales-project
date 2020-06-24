package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;

import java.util.List;

public interface IContractDetailTypeParamService {

    ContractDetailTypeParamDTO.Info get(Long id);

    List<ContractDetailTypeParamDTO.Info> findByContractDetailType(Long id);

    List<ContractDetailTypeParamDTO.Info> getAll(List<Long> ids);

    List<ContractDetailTypeParamDTO.Info> list();

    ContractDetailTypeParamDTO.Info create(ContractDetailTypeParamDTO.Create request);

    List<ContractDetailTypeParamDTO.Info> createAll(List<ContractDetailTypeParamDTO.Create> requests);

    ContractDetailTypeParamDTO.Info update(ContractDetailTypeParamDTO.Update request);

    ContractDetailTypeParamDTO.Info update(Long id, ContractDetailTypeParamDTO.Update request);

    List<ContractDetailTypeParamDTO.Info> updateAll(List<ContractDetailTypeParamDTO.Update> requests);

    List<ContractDetailTypeParamDTO.Info> updateAll(List<Long> ids, List<ContractDetailTypeParamDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDetailTypeParamDTO.Delete request);

    TotalResponse<ContractDetailTypeParamDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailTypeParamDTO.Info> search(SearchDTO.SearchRq request);
}