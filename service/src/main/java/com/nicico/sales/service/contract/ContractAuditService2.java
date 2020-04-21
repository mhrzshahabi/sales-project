package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractAuditDTO2;
import com.nicico.sales.iservice.contract.IContractAuditService2;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractAudit2;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractAuditService2 extends GenericService<ContractAudit2, AuditId, ContractAuditDTO2.Create, ContractAuditDTO2.Info, ContractAuditDTO2.Update, ContractAuditDTO2.Delete> implements IContractAuditService2 {
}
