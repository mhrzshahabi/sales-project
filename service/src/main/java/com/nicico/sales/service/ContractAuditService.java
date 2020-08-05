package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractAuditDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IContractAuditService;
import com.nicico.sales.model.entities.base.ContractAudit;
import com.nicico.sales.repository.ContractAuditDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractAuditService implements IContractAuditService {

    private final ContractAuditDAO contractAuditDAO;
    private final ModelMapper modelMapper;

    @Override
    public ContractAuditDTO.Info get(ContractAudit.ContractAuditId id) {
        final Optional<ContractAudit> slById = contractAuditDAO.findById(id);
        final ContractAudit contractAudit = slById.orElseThrow(() -> new NotFoundException(ContractAudit.class));

        return modelMapper.map(contractAudit, ContractAuditDTO.Info.class);
    }

    @Override
    public List<ContractAuditDTO.Info> list() {
        final List<ContractAudit> slAll = contractAuditDAO.findAll();
        return modelMapper.map(slAll, new TypeToken<List<ContractAuditDTO.Info>>() {
        }.getType());
    }

    @Override
    public TotalResponse<ContractAuditDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(contractAuditDAO, criteria, contractAudit -> modelMapper.map(contractAudit, ContractAuditDTO.Info.class));
    }
}
