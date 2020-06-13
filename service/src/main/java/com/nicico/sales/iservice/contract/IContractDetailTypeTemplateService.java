package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;

import java.util.List;

public interface IContractDetailTypeTemplateService {

    ContractDetailTypeTemplateDTO.Info get(Long id);

    List<ContractDetailTypeTemplateDTO.Info> getAll(List<Long> ids);

    List<ContractDetailTypeTemplateDTO.Info> findByContractDetailType(Long id);

    List<ContractDetailTypeTemplateDTO.Info> list();

    ContractDetailTypeTemplateDTO.Info create(ContractDetailTypeTemplateDTO.Create request);

    List<ContractDetailTypeTemplateDTO.Info> createAll(List<ContractDetailTypeTemplateDTO.Create> requests);

    ContractDetailTypeTemplateDTO.Info update(ContractDetailTypeTemplateDTO.Update request);

    ContractDetailTypeTemplateDTO.Info update(Long id, ContractDetailTypeTemplateDTO.Update request);

    List<ContractDetailTypeTemplateDTO.Info> updateAll(List<ContractDetailTypeTemplateDTO.Update> requests);

    List<ContractDetailTypeTemplateDTO.Info> updateAll(List<Long> ids, List<ContractDetailTypeTemplateDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDetailTypeTemplateDTO.Delete request);

    TotalResponse<ContractDetailTypeTemplateDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailTypeTemplateDTO.Info> search(SearchDTO.SearchRq request);
}