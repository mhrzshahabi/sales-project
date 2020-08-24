package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ContractShipmentAuditDTO;
import com.nicico.sales.dto.ContractShipmentDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IContractShipmentService;
import com.nicico.sales.model.entities.base.ContractShipment;
import com.nicico.sales.model.entities.base.ContractShipmentAudit;
import com.nicico.sales.repository.ContractShipmentAuditDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ContractShipmentService extends GenericService<ContractShipment, Long, ContractShipmentDTO.Create, ContractShipmentDTO.Info, ContractShipmentDTO.Update, ContractShipmentDTO.Delete> implements IContractShipmentService {

    private final ContractShipmentAuditDAO contractShipmentAuditDAO;

    @Transactional(readOnly = true)
    @Override
    @Action(value = ActionType.List)
    public List<ContractShipmentAuditDTO.Info> listAudit() {
        final List<ContractShipmentAudit> slAll = contractShipmentAuditDAO.findAll();
        return modelMapper.map(slAll, new TypeToken<List<ContractShipmentAuditDTO.Info>>() {
        }.getType());
    }


    @Transactional(readOnly = true)
    @Override
    @Action(value = ActionType.Search)
    public TotalResponse<ContractShipmentAuditDTO.Info> searchAudit(NICICOCriteria criteria) {
        return SearchUtil.search(contractShipmentAuditDAO, criteria, contractShipmentAudit -> modelMapper.map(contractShipmentAudit, ContractShipmentAuditDTO.Info.class));
    }
}
