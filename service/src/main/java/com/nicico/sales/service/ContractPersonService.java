package com.nicico.sales.service;

import com.nicico.sales.dto.ContractPersonDTO;
import com.nicico.sales.iservice.IContractPersonService;
import com.nicico.sales.model.entities.base.ContractPerson;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ContractPersonService extends GenericService<ContractPerson, Long, ContractPersonDTO.Create, ContractPersonDTO.Info, ContractPersonDTO.Update, ContractPersonDTO.Delete> implements IContractPersonService {

}
