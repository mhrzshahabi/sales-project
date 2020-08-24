package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IShipmentService;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.repository.ShipmentDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ShipmentService extends GenericService<Shipment, Long, ShipmentDTO.Create, ShipmentDTO.Info, ShipmentDTO.Update, ShipmentDTO.Delete> implements IShipmentService {


    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.List)
    public List<Object[]> pickListShipment() {
        return ((ShipmentDAO) repository).pickListShipment();
    }

    @Override
    @PreAuthorize("hasAuthority('O_SHIPMENT')")
    public List<String> inspector() {
        return ((ShipmentDAO) repository).inspector();
    }
}
