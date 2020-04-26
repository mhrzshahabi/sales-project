package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailValueAuditDTO;
import com.nicico.sales.iservice.contract.IContractDetailValueAuditService;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractDetailValueAudit;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailValueAuditService extends GenericService<ContractDetailValueAudit, AuditId, ContractDetailValueAuditDTO.Create, ContractDetailValueAuditDTO.Info, ContractDetailValueAuditDTO.Update, ContractDetailValueAuditDTO.Delete> implements IContractDetailValueAuditService {
}