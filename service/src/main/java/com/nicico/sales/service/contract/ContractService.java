package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDTO;
import com.nicico.sales.iservice.contract.IContractService;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractService extends GenericService<Contract, Long, ContractDTO.Create, ContractDTO.Info, ContractDTO.Update, ContractDTO.Delete> implements IContractService {
}