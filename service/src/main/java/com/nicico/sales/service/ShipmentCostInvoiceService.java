package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ShipmentCostInvoiceDTO;
import com.nicico.sales.dto.ShipmentCostInvoiceDetailDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IShipmentCostInvoiceService;
import com.nicico.sales.model.entities.base.ShipmentCostInvoice;
import com.nicico.sales.model.entities.base.ShipmentCostInvoiceDetail;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@RequiredArgsConstructor
@Service
public class ShipmentCostInvoiceService extends GenericService<ShipmentCostInvoice, Long, ShipmentCostInvoiceDTO.Create, ShipmentCostInvoiceDTO.Info, ShipmentCostInvoiceDTO.Update, ShipmentCostInvoiceDTO.Delete> implements IShipmentCostInvoiceService {

    private final  ShipmentCostInvoiceDetailService shipmentCostInvoiceDetailService;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ShipmentCostInvoiceDTO.Info create(ShipmentCostInvoiceDTO.Create request) {

        ShipmentCostInvoiceDTO.Info shipmentCostInvoiceDTO = super.create(request);

        request.getShipmentCostInvoiceDetails().forEach(item -> item.setShipmentCostInvoiceId(shipmentCostInvoiceDTO.getId()));
        shipmentCostInvoiceDetailService.createAll(modelMapper.map(request.getShipmentCostInvoiceDetails(), new TypeToken<List<ShipmentCostInvoiceDetailDTO.Create>>() {}.getType()));

        return shipmentCostInvoiceDTO;
    }
}
