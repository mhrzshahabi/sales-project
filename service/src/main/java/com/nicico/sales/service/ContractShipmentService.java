package com.nicico.sales.service;

import com.nicico.sales.dto.ContractShipmentDTO;
import com.nicico.sales.iservice.IContractShipmentService;
import com.nicico.sales.model.entities.base.ContractShipment;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ContractShipmentService extends GenericService<ContractShipment, Long, ContractShipmentDTO.Create, ContractShipmentDTO.Info, ContractShipmentDTO.Update, ContractShipmentDTO.Delete> implements IContractShipmentService {
//
//    private final ContractShipmentAuditDAO contractShipmentAuditDAO;
//
//    @Transactional(readOnly = true)
//    @Override
//    @Action(value = ActionType.List)
//    public List<ContractShipmentAuditDTO.Info> listAudit() {
//        final List<ContractShipmentAudit> slAll = contractShipmentAuditDAO.findAll();
//        return modelMapper.map(slAll, new TypeToken<List<ContractShipmentAuditDTO.Info>>() {
//        }.getType());
//    }
//
//
//    @Transactional(readOnly = true)
//    @Override
//    @Action(value = ActionType.Search)
//    public TotalResponse<ContractShipmentAuditDTO.Info> searchAudit(NICICOCriteria criteria) {
//        return SearchUtil.search(contractShipmentAuditDAO, criteria, contractShipmentAudit -> modelMapper.map(contractShipmentAudit, ContractShipmentAuditDTO.Info.class));
//    }
}
