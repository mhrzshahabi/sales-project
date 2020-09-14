package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ShipmentCostInvoiceDetailDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IShipmentCostInvoiceDetailService;
import com.nicico.sales.model.entities.base.ShipmentCostInvoiceDetail;
import com.nicico.sales.repository.ShipmentCostInvoiceDetailDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class ShipmentCostInvoiceDetailService extends GenericService<ShipmentCostInvoiceDetail, Long, ShipmentCostInvoiceDetailDTO.Create, ShipmentCostInvoiceDetailDTO.Info, ShipmentCostInvoiceDetailDTO.Update, ShipmentCostInvoiceDetailDTO.Delete> implements IShipmentCostInvoiceDetailService {

    @Override
    @Transactional
    @Action(value = ActionType.Get)
    public List<ShipmentCostInvoiceDetail> getAllByShipmentCostDutyId(Long id) {
        return ((ShipmentCostInvoiceDetailDAO) repository).getAllByShipmentCostDutyId(id);
    }

}
