package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.ContractContactDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractContact;
import com.nicico.sales.model.enumeration.CommercialRole;

public interface IContractContactService extends IGenericService<ContractContact, Long, ContractContactDTO.Create, ContractContactDTO.Info, ContractContactDTO.Update, ContractContactDTO.Delete> {

    ContractContactDTO.Info getByContractIdAndContactIdAndCommercialRole(Long contractId, Long contactId, CommercialRole commercialRole);
}
