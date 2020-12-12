package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractContactDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.contract.IContractContactService;
import com.nicico.sales.model.entities.contract.ContractContact;
import com.nicico.sales.model.enumeration.CommercialRole;
import com.nicico.sales.repository.contract.ContractContactDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ContractContactService extends GenericService<ContractContact, Long, ContractContactDTO.Create, ContractContactDTO.Info, ContractContactDTO.Update, ContractContactDTO.Delete> implements IContractContactService {

    @Override
    @Transactional
    @Action(value = ActionType.Get)
    public ContractContactDTO.Info getByContractIdAndContactIdAndCommercialRole(Long contractId, Long contactId, CommercialRole commercialRole) {
        ContractContact contractContact = ((ContractContactDAO) repository).findByContractIdAndContactIdAndCommercialRole(contractId, contactId, commercialRole)
                .orElseThrow(() -> new NotFoundException(ContractContact.class));
        return modelMapper.map(contractContact, ContractContactDTO.Info.class);
    }
}
