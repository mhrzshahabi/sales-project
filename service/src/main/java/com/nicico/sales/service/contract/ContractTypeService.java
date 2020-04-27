package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractTypeDTO;
import com.nicico.sales.iservice.contract.IContractTypeService;
import com.nicico.sales.model.entities.contract.ContractType;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractTypeService extends GenericService<ContractType, Long, ContractTypeDTO.Create, ContractTypeDTO.Info, ContractTypeDTO.Update, ContractTypeDTO.Delete> implements IContractTypeService {
}