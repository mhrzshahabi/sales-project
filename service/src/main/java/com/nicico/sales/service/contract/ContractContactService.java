package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractContactDTO;
import com.nicico.sales.iservice.contract.IContractContactService;
import com.nicico.sales.model.entities.contract.ContractContact;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractContactService extends GenericService<ContractContact, Long, ContractContactDTO.Create, ContractContactDTO.Info, ContractContactDTO.Update, ContractContactDTO.Delete> implements IContractContactService {
}