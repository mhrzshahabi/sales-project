package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractAuditDTO;
import com.nicico.sales.iservice.contract.IContractAuditService;
import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractAudit;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractAuditService extends GenericService<ContractAudit, AuditId, ContractAuditDTO.Create, ContractAuditDTO.Info, ContractAuditDTO.Update, ContractAuditDTO.Delete> implements IContractAuditService {
}