package com.nicico.sales.service;


import com.nicico.sales.dto.ShipmentMethodDTO;
import com.nicico.sales.iservice.IShipmentMethodService;
import com.nicico.sales.model.entities.base.ShipmentMethod;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ShipmentMethodService extends GenericService<ShipmentMethod, Long, ShipmentMethodDTO.Create, ShipmentMethodDTO.Info, ShipmentMethodDTO.Update, ShipmentMethodDTO.Delete> implements IShipmentMethodService {
}
