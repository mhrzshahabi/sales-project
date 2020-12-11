package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.ContractDetailValueDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractDetailValue;

public interface IContractDetailValueService extends IGenericService<ContractDetailValue, Long, ContractDetailValueDTO.Create, ContractDetailValueDTO.Info, ContractDetailValueDTO.Update, ContractDetailValueDTO.Delete> {
}