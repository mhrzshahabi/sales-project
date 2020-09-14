package com.nicico.sales.service;


import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ShipmentCostDutyDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IShipmentCostDutyService;
import com.nicico.sales.iservice.IShipmentCostInvoiceDetailService;
import com.nicico.sales.model.entities.base.ShipmentCostDuty;
import com.nicico.sales.model.entities.base.ShipmentCostInvoiceDetail;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Locale;

@Service
@RequiredArgsConstructor
public class ShipmentCostDutyService extends GenericService<ShipmentCostDuty, Long, ShipmentCostDutyDTO.Create, ShipmentCostDutyDTO.Info, ShipmentCostDutyDTO.Update, ShipmentCostDutyDTO.Delete> implements IShipmentCostDutyService {

    private final ResourceBundleMessageSource messageSource;
    private final IShipmentCostInvoiceDetailService shipmentCostInvoice;
    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ShipmentCostDutyDTO.Info update(Long id, ShipmentCostDutyDTO.Update request) {

        List<ShipmentCostInvoiceDetail> shipmentCostInvoiceDetail = shipmentCostInvoice.getAllByShipmentCostDutyId(request.getId());
        Locale locale = LocaleContextHolder.getLocale();
         String message = messageSource.getMessage("exception.updateShipmentCostDuty",null, locale);

        if (!shipmentCostInvoiceDetail.isEmpty()) throw  new SalesException2(ErrorType.NotFound, "id", message);

        ShipmentCostDuty shipmentCostDuty = repository.findById(id).orElseThrow(() -> new NotFoundException(ShipmentCostDuty.class));
        ShipmentCostDuty updating = new ShipmentCostDuty();
        modelMapper.map(shipmentCostDuty, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        return save(updating);

    }
}

