package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailValueDTO;
import com.nicico.sales.iservice.contract.IContractDetailValueService;
import com.nicico.sales.model.entities.contract.ContractDetailValue;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailValueService extends GenericService<ContractDetailValue, Long, ContractDetailValueDTO.Create, ContractDetailValueDTO.Info, ContractDetailValueDTO.Update, ContractDetailValueDTO.Delete> implements IContractDetailValueService {
}