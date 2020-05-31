package com.nicico.sales.service;


import com.nicico.sales.dto.ShipmentTypeDTO;
import com.nicico.sales.iservice.IShipmentTypeService;
import com.nicico.sales.model.entities.base.ShipmentType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ShipmentTypeService extends GenericService<ShipmentType, Long, ShipmentTypeDTO.Create, ShipmentTypeDTO.Info, ShipmentTypeDTO.Update, ShipmentTypeDTO.Delete> implements IShipmentTypeService {

}
