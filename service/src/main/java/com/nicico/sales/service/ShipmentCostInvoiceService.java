package com.nicico.sales.service;

import com.nicico.sales.dto.ShipmentCostInvoiceDTO;
import com.nicico.sales.iservice.IShipmentCostInvoiceService;
import com.nicico.sales.model.entities.base.ShipmentCostInvoice;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ShipmentCostInvoiceService extends GenericService<ShipmentCostInvoice, Long, ShipmentCostInvoiceDTO.Create, ShipmentCostInvoiceDTO.Info, ShipmentCostInvoiceDTO.Update, ShipmentCostInvoiceDTO.Delete> implements IShipmentCostInvoiceService {

}
