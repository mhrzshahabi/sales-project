package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.iservice.contract.IContractService2;
import com.nicico.sales.model.entities.contract.Contract2;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractService2 extends GenericService<Contract2, Long, ContractDTO2.Create, ContractDTO2.Info, ContractDTO2.Update, ContractDTO2.Delete> implements IContractService2 {
}
