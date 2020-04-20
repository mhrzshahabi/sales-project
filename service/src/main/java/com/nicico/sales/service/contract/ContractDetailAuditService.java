package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailAuditDTO;
import com.nicico.sales.iservice.contract.IContractDetailAuditService;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractDetailAudit;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailAuditService extends GenericService<ContractDetailAudit, AuditId, ContractDetailAuditDTO.Create, ContractDetailAuditDTO.Info, ContractDetailAuditDTO.Update, ContractDetailAuditDTO.Delete> implements IContractDetailAuditService {
}