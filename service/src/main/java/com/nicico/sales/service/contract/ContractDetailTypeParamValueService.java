package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailTypeParamValueDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamValueService;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParamValue;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeParamValueService extends GenericService<ContractDetailTypeParamValue, Long, ContractDetailTypeParamValueDTO.Create, ContractDetailTypeParamValueDTO.Info, ContractDetailTypeParamValueDTO.Update, ContractDetailTypeParamValueDTO.Delete> implements IContractDetailTypeParamValueService {
}