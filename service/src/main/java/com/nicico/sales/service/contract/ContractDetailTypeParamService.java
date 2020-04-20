package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamService;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeParamService extends GenericService<ContractDetailTypeParam, Long, ContractDetailTypeParamDTO.Create, ContractDetailTypeParamDTO.Info, ContractDetailTypeParamDTO.Update, ContractDetailTypeParamDTO.Delete> implements IContractDetailTypeParamService {
}