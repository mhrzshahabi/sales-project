package com.nicico.sales.service;

import com.nicico.sales.dto.ShipmentContractDTO;
import com.nicico.sales.iservice.IShipmentContractService;
import com.nicico.sales.model.entities.base.ShipmentContract;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class ShipmentContractService extends GenericService<ShipmentContract, Long, ShipmentContractDTO.Create, ShipmentContractDTO.Info, ShipmentContractDTO.Update, ShipmentContractDTO.Delete> implements IShipmentContractService {
}
