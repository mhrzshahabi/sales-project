package com.nicico.sales.service;


import com.nicico.sales.dto.ShipmentCostDutyDTO;
import com.nicico.sales.iservice.IShipmentCostDutyService;
import com.nicico.sales.model.entities.base.ShipmentCostDuty;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ShipmentCostDutyService extends GenericService<ShipmentCostDuty, Long, ShipmentCostDutyDTO.Create, ShipmentCostDutyDTO.Info, ShipmentCostDutyDTO.Update, ShipmentCostDutyDTO.Delete> implements IShipmentCostDutyService {
}
