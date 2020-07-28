package com.nicico.sales.service;

import com.nicico.sales.dto.ShipmentCostInvoiceDetailDTO;
import com.nicico.sales.iservice.IShipmentCostInvoiceDetailService;
import com.nicico.sales.model.entities.base.ShipmentCostInvoiceDetail;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ShipmentCostInvoiceDetailService extends GenericService<ShipmentCostInvoiceDetail, Long, ShipmentCostInvoiceDetailDTO.Create, ShipmentCostInvoiceDetailDTO.Info, ShipmentCostInvoiceDetailDTO.Update, ShipmentCostInvoiceDetailDTO.Delete> implements IShipmentCostInvoiceDetailService {

}
