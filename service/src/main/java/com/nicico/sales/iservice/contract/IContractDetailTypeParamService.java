package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;

import java.util.List;

public interface IContractDetailTypeParamService extends IGenericService<ContractDetailTypeParam, Long, ContractDetailTypeParamDTO.Create, ContractDetailTypeParamDTO.Info, ContractDetailTypeParamDTO.Update, ContractDetailTypeParamDTO.Delete> {

    List<ContractDetailTypeParamDTO.Info> findByContractDetailType(Long id);
}