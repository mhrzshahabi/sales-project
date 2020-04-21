package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.iservice.contract.IContractDetailService2;
import com.nicico.sales.model.entities.contract.ContractDetail2;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailService2 extends GenericService<ContractDetail2, Long, ContractDetailDTO.Create, ContractDetailDTO.Info, ContractDetailDTO.Update, ContractDetailDTO.Delete> implements IContractDetailService2 {
}
