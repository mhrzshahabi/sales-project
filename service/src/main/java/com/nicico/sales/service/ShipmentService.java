package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.repository.ShipmentDAO;
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
public class ShipmentService implements IShipmentService {

    private final ShipmentDAO shipmentDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_SHIPMENT')")
    public ShipmentDTO.Info get(Long id) {
        final Optional<Shipment> slById = shipmentDAO.findById(id);
        final Shipment shipment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentNotFound));

        return modelMapper.map(shipment, ShipmentDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_SHIPMENT')")
    public List<ShipmentDTO.Info> list() {
        final List<Shipment> slAll = shipmentDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ShipmentDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_SHIPMENT')")
    public ShipmentDTO.Info create(ShipmentDTO.Create request) {
        final Shipment shipment = modelMapper.map(request, Shipment.class);

        return save(shipment);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_SHIPMENT')")
    public ShipmentDTO.Info update(Long id, ShipmentDTO.Update request) {
        final Optional<Shipment> slById = shipmentDAO.findById(id);
        final Shipment shipment = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ShipmentNotFound));

        Shipment updating = new Shipment();
        modelMapper.map(shipment, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_SHIPMENT')")
    public void delete(Long id) {
        shipmentDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_SHIPMENT')")
    public void delete(ShipmentDTO.Delete request) {
        final List<Shipment> shipments = shipmentDAO.findAllById(request.getIds());

        shipmentDAO.deleteAll(shipments);
    }


    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_SHIPMENT')")
    public TotalResponse<ShipmentDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(shipmentDAO, criteria, instruction -> modelMapper.map(instruction, ShipmentDTO.Info.class));
    }

    private ShipmentDTO.Info save(Shipment shipment) {
        final Shipment saved = shipmentDAO.saveAndFlush(shipment);
        return modelMapper.map(saved, ShipmentDTO.Info.class);
    }

    @PreAuthorize("hasAuthority('R_SHIPMENT')")
    public List<Object[]> pickListShipment() {
        return shipmentDAO.pickListShipment();
    }

    @Override
    @PreAuthorize("hasAuthority('O_SHIPMENT')")
    public List<String> findLotname(String id) {
        return shipmentDAO.findLotname(id);
    }


    @Override
    @PreAuthorize("hasAuthority('O_SHIPMENT')")
    public List<String> findbooking(String id) {
        return shipmentDAO.findbooking(id);
    }

    @Override
    @PreAuthorize("hasAuthority('O_SHIPMENT')")
    public List<String> cname() {
        return shipmentDAO.cname();
    }

    @Override
    @PreAuthorize("hasAuthority('O_SHIPMENT')")
    public List<String> inspector() {
        return shipmentDAO.inspector();
    }
}
