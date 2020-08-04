package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractShipmentAuditDTO;
import com.nicico.sales.dto.ContractShipmentDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IContractShipmentService;
import com.nicico.sales.model.entities.base.ContractShipment;
import com.nicico.sales.model.entities.base.ContractShipmentAudit;
import com.nicico.sales.repository.ContractShipmentAuditDAO;
import com.nicico.sales.repository.ContractShipmentDAO;
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
public class ContractShipmentService implements IContractShipmentService {

    private final ContractShipmentDAO contractShipmentDAO;
    private final ContractShipmentAuditDAO contractShipmentAuditDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_CONTRACT_SHIPMENT')")
    public ContractShipmentDTO.Info get(Long id) {
        final Optional<ContractShipment> slById = contractShipmentDAO.findById(id);
        final ContractShipment contractShipment = slById.orElseThrow(() -> new NotFoundException(ContractShipment.class));

        return modelMapper.map(contractShipment, ContractShipmentDTO.Info.class);
    }


    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_SHIPMENT')")
    public List<ContractShipmentDTO.Info> list() {
        final List<ContractShipment> slAll = contractShipmentDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContractShipmentDTO.Info>>() {
        }.getType());
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_SHIPMENT')")
    public List<ContractShipmentAuditDTO.Info> listAudit() {
        final List<ContractShipmentAudit> slAll = contractShipmentAuditDAO.findAll();
        return modelMapper.map(slAll, new TypeToken<List<ContractShipmentAuditDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_CONTRACT_SHIPMENT')")
    public ContractShipmentDTO.Info create(ContractShipmentDTO.Create request) {
        final ContractShipment contractShipment = modelMapper.map(request, ContractShipment.class);

        return save(contractShipment);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_CONTRACT_SHIPMENT')")
    public ContractShipmentDTO.Info update(Long id, ContractShipmentDTO.Update request) {
        final Optional<ContractShipment> slById = contractShipmentDAO.findById(id);
        final ContractShipment contractShipment = slById.orElseThrow(() -> new NotFoundException(ContractShipment.class));

        ContractShipment updating = new ContractShipment();
        modelMapper.map(contractShipment, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTRACT_SHIPMENT')")
    public void delete(Long id) {
        contractShipmentDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTRACT_SHIPMENT')")
    public void delete(ContractShipmentDTO.Delete request) {
        final List<ContractShipment> contractShipments = contractShipmentDAO.findAllById(request.getIds());

        contractShipmentDAO.deleteAll(contractShipments);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_SHIPMENT')")
    public TotalResponse<ContractShipmentDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(contractShipmentDAO, criteria, contractShipment -> modelMapper.map(contractShipment, ContractShipmentDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_SHIPMENT')")
    public TotalResponse<ContractShipmentAuditDTO.Info> searchAudit(NICICOCriteria criteria) {
        return SearchUtil.search(contractShipmentAuditDAO, criteria, contractShipmentAudit -> modelMapper.map(contractShipmentAudit, ContractShipmentAuditDTO.Info.class));
    }


    private ContractShipmentDTO.Info save(ContractShipment contractShipment) {
        final ContractShipment saved = contractShipmentDAO.save(contractShipment);
        return modelMapper.map(saved, ContractShipmentDTO.Info.class);
    }
}
