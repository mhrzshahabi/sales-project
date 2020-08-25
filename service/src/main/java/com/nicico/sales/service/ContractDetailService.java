package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ContractDetailAuditDTO;
import com.nicico.sales.dto.ContractDetailDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IContractDetailService;
import com.nicico.sales.model.entities.base.ContractDetail;
import com.nicico.sales.repository.ContractDetailAuditDAO;
import com.nicico.sales.repository.ContractDetailDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContractDetailService extends GenericService<ContractDetail, Long, ContractDetailDTO.Create, ContractDetailDTO.Info, ContractDetailDTO.Update, ContractDetailDTO.Delete> implements IContractDetailService {

    private final ContractDetailAuditDAO contractDetailAuditDAO;

    @Override
    @Action(value = ActionType.Get)
    @Transactional(readOnly = true)
    public ContractDetailDTO.Info findByContractID(Long id) {
        ContractDetail byContract_id = ((ContractDetailDAO) repository).findByContract_id(id);
        return modelMapper.map(byContract_id, ContractDetailDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_DETAIL')")
    public TotalResponse<ContractDetailAuditDTO.Info> searchAudit(NICICOCriteria criteria) {
        return SearchUtil.search(contractDetailAuditDAO, criteria, contractDetailAudit -> modelMapper.map(contractDetailAudit, ContractDetailAuditDTO.Info.class));
    }

}
