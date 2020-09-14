package com.nicico.sales.iservice;

import com.nicico.sales.dto.ShipmentCostInvoiceDetailDTO;
import com.nicico.sales.model.entities.base.ShipmentCostInvoiceDetail;

import java.util.List;

public interface IShipmentCostInvoiceDetailService extends IGenericService<ShipmentCostInvoiceDetail, Long, ShipmentCostInvoiceDetailDTO.Create, ShipmentCostInvoiceDetailDTO.Info, ShipmentCostInvoiceDetailDTO.Update, ShipmentCostInvoiceDetailDTO.Delete> {

    List<ShipmentCostInvoiceDetail> getAllByShipmentCostDutyId(Long id);
}
