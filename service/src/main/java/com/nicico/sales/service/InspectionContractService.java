package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.InspectionContractDTO;
import com.nicico.sales.iservice.IInspectionContractService;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.model.entities.base.InspectionContract;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.repository.InspectionContractDAO;
import com.nicico.sales.repository.ShipmentDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class InspectionContractService implements IInspectionContractService {

    private final InspectionContractDAO inspectionContractDAO;
    private final ShipmentDAO shipmentDAO;
    private final ModelMapper modelMapper;
    private final IShipmentService shipmentService;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_INSPECTION_CONTRACT')")
    public InspectionContractDTO.Info get(Long id) {
        final Optional<InspectionContract> slById = inspectionContractDAO.findById(id);
        final InspectionContract inspectionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InspectionContractNotFound));

        return modelMapper.map(inspectionContract, InspectionContractDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_INSPECTION_CONTRACT')")
    public List<InspectionContractDTO.Info> list() {
        final List<InspectionContract> slAll = inspectionContractDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<InspectionContractDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_INSPECTION_CONTRACT')")
    public InspectionContractDTO.Info create(InspectionContractDTO.Create request) {
        final InspectionContract inspectionContract = modelMapper.map(request, InspectionContract.class);

        return save(inspectionContract);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_INSPECTION_CONTRACT')")
    public InspectionContractDTO.Info update(Long id, InspectionContractDTO.Update request) {
        final Optional<InspectionContract> slById = inspectionContractDAO.findById(id);
        final InspectionContract inspectionContract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.InspectionContractNotFound));

        InspectionContract updating = new InspectionContract();
        modelMapper.map(inspectionContract, updating);
        modelMapper.map(request, updating);
        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INSPECTION_CONTRACT')")
    public void delete(Long id) {
        inspectionContractDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_INSPECTION_CONTRACT')")
    public void delete(InspectionContractDTO.Delete request) {
        final List<InspectionContract> inspectionContracts = inspectionContractDAO.findAllById(request.getIds());

        inspectionContractDAO.deleteAll(inspectionContracts);
    }

    @Override
    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_INSPECTION_CONTRACT')")
    public TotalResponse<InspectionContractDTO.Info> search(MultiValueMap<String, String> criteria) {
        final NICICOCriteria request = NICICOCriteria.of(criteria);

        return SearchUtil.search(inspectionContractDAO, request, entity -> modelMapper.map(entity, InspectionContractDTO.Info.class));
    }


    private InspectionContractDTO.Info save(InspectionContract inspectionContract) {
        final InspectionContract saved = inspectionContractDAO.saveAndFlush(inspectionContract);
        return modelMapper.map(saved, InspectionContractDTO.Info.class);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public String getMaterial(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*********Inspection not found********"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("*******Shipment not found*********"));
        String mola = sh.getMaterial().getDescl();
        return mola;
    }


    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public String ves(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("********Inspection not found********"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("*********Shipment not found*********"));
        String ves = sh.getVessel().getName();
        return ves;
    }


    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public String amount(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("********Inspection not found*********"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("*********Shipment not found********"));
        String amount = String.valueOf(sh.getAmount());
        return amount;
    }

    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public String port(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
        String port = String.valueOf(sh.getPortByDischarge().getPort());
        return port;
    }

    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public String loading(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
        String loading = String.valueOf(sh.getPortByLoading().getPort());
        return loading;
    }


    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public String buyer(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
        String buyer = String.valueOf(sh.getContact().getNameEN());
        return buyer;
    }

    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public String contractNo(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
        String contractNo = String.valueOf(sh.getContract().getContractNo());
        return contractNo;
    }


    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public List<String> email(Long id) {
        InspectionContract ic = inspectionContractDAO.findById(id).orElseThrow(() -> new RuntimeException("*******Inspection not found*************"));
        Shipment sh = shipmentDAO.findById(ic.getShipmentId()).orElseThrow(() -> new RuntimeException("**********Shipment not found*********"));
        Long buyer = sh.getContact().getId();
        return inspectionContractDAO.email(buyer);
    }

    @Transactional
    @PreAuthorize("hasAuthority('O_INSPECTION_CONTRACT')")
    public List<String> emailSel() {
        return inspectionContractDAO.email(4152L);
    }

}