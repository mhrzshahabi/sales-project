package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailDTO2;
import com.nicico.sales.iservice.contract.IContractDetailService2;
import com.nicico.sales.model.entities.contract.ContractDetail2;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailService2 extends GenericService<ContractDetail2, Long, ContractDetailDTO2.Create, ContractDetailDTO2.Info, ContractDetailDTO2.Update, ContractDetailDTO2.Delete> implements IContractDetailService2 {
}
