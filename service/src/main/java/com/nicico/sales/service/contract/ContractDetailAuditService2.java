package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailAuditDTO2;
import com.nicico.sales.iservice.contract.IContractDetailAuditService2;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractDetailAudit2;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailAuditService2 extends GenericService<ContractDetailAudit2, AuditId, ContractDetailAuditDTO2.Create, ContractDetailAuditDTO2.Info, ContractDetailAuditDTO2.Update, ContractDetailAuditDTO2.Delete> implements IContractDetailAuditService2 {
}