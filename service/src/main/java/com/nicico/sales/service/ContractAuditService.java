package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ContractAuditDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IContractAuditService;
import com.nicico.sales.model.entities.base.ContractAudit;
import com.nicico.sales.repository.ContractAuditDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractAuditService extends GenericService<ContractAudit, ContractAudit.ContractAuditId, ContractAuditDTO, ContractAuditDTO.Info, ContractAuditDTO, ContractAuditDTO> implements IContractAuditService {


    @Override
    @Action(value = ActionType.Get)
    @Transactional(readOnly = true)
    public ContractAuditDTO.Info get(ContractAudit.ContractAuditId id) {
        final Optional<ContractAudit> slById = repository.findById(id);
        final ContractAudit contractAudit = slById.orElseThrow(() -> new NotFoundException(ContractAudit.class));

        return modelMapper.map(contractAudit, ContractAuditDTO.Info.class);
    }

}
