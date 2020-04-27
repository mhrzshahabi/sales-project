package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeService;
import com.nicico.sales.model.entities.contract.ContractDetailType;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeService extends GenericService<ContractDetailType, Long, ContractDetailTypeDTO.Create, ContractDetailTypeDTO.Info, ContractDetailTypeDTO.Update, ContractDetailTypeDTO.Delete> implements IContractDetailTypeService {
}