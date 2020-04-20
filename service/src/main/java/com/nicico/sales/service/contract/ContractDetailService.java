package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.iservice.contract.IContractDetailService;
import com.nicico.sales.model.entities.contract.ContractDetail;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailService extends GenericService<ContractDetail, Long, ContractDetailDTO.Create, ContractDetailDTO.Info, ContractDetailDTO.Update, ContractDetailDTO.Delete> implements IContractDetailService {
}