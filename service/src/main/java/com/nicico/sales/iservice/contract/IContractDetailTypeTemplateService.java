package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractDetailTypeTemplate;

import java.util.List;

public interface IContractDetailTypeTemplateService extends IGenericService<ContractDetailTypeTemplate, Long, ContractDetailTypeTemplateDTO.Create, ContractDetailTypeTemplateDTO.Info, ContractDetailTypeTemplateDTO.Update, ContractDetailTypeTemplateDTO.Delete> {

    List<ContractDetailTypeTemplateDTO.Info> findByContractDetailType(Long id);
}