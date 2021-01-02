package com.nicico.sales.iservice;

import com.nicico.sales.dto.ShipmentCostInvoiceDTO;
import com.nicico.sales.model.entities.base.ShipmentCostInvoice;

import java.util.List;

public interface IShipmentCostInvoiceService extends IGenericService<ShipmentCostInvoice, Long, ShipmentCostInvoiceDTO.Create, ShipmentCostInvoiceDTO.Info, ShipmentCostInvoiceDTO.Update, ShipmentCostInvoiceDTO.Delete> {

    void updateDeletedDocument(List<ShipmentCostInvoiceDTO.Info> data);

    ShipmentCostInvoiceDTO.Info toUnsent(Long id);

}
