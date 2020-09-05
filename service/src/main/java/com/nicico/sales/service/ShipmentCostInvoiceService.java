package com.nicico.sales.service;

import com.ghasemkiani.util.icu.PersianCalendar;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.dto.InvoiceTypeDTO;
import com.nicico.sales.dto.ShipmentCostInvoiceDTO;
import com.nicico.sales.dto.ShipmentCostInvoiceDetailDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IShipmentCostInvoiceService;
import com.nicico.sales.model.entities.base.ShipmentCostInvoice;
import com.nicico.sales.model.entities.base.ShipmentCostInvoiceDetail;
import com.nicico.sales.utility.InvoiceNoGenerator;
import com.nicico.sales.utility.UpdateUtil;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

@RequiredArgsConstructor
@Service
public class ShipmentCostInvoiceService extends GenericService<ShipmentCostInvoice, Long, ShipmentCostInvoiceDTO.Create, ShipmentCostInvoiceDTO.Info, ShipmentCostInvoiceDTO.Update, ShipmentCostInvoiceDTO.Delete> implements IShipmentCostInvoiceService {

    private final ShipmentCostInvoiceDetailService shipmentCostInvoiceDetailService;
    private final InvoiceTypeService invoiceTypeService;
    private final ContractService contractService;
    private final InvoiceNoGenerator invoiceNoGenerator;
    private final ResourceBundleMessageSource messageSource;
    private final UpdateUtil updateUtil;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ShipmentCostInvoiceDTO.Info create(ShipmentCostInvoiceDTO.Create request) {

        PersianCalendar calendar = new PersianCalendar(request.getInvoiceDate());
        InvoiceTypeDTO.Info invoiceTypeDTO = invoiceTypeService.get(request.getInvoiceTypeId());
        ContractDTO.Info contractDTO = contractService.get(request.getContractId());

        request.setInvoiceNo(invoiceNoGenerator.createInvoiceNo(invoiceTypeDTO.getTitle(), calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH) + 1, contractDTO.getMaterial().getAbbreviation(), contractDTO.getContractNo()));

        ShipmentCostInvoiceDTO.Info shipmentCostInvoiceDTO = super.create(request);

        request.getShipmentCostInvoiceDetails().forEach(item -> item.setShipmentCostInvoiceId(shipmentCostInvoiceDTO.getId()));
        shipmentCostInvoiceDetailService.createAll(modelMapper.map(request.getShipmentCostInvoiceDetails(), new TypeToken<List<ShipmentCostInvoiceDetailDTO.Create>>() {
        }.getType()));

        return shipmentCostInvoiceDTO;
    }

    /*@Override
    @Action(value = ActionType.Finalize)
    @Transactional
    public ShipmentCostInvoiceDTO.Info finalize(Long id) {

        ShipmentCostInvoiceDTO.Info shipmentCostInvoiceDTO = super.finalize(id);
        List<EStatus> eStatus = shipmentCostInvoiceDTO.getEStatus();
        for (int i = 0; i < eStatus.size(); i++) {
//            if (eStatus.get(i).name.contains("Final")) {
//            }
        }
        if (shipmentCostInvoiceDTO.getEStatus().contains("Final")) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(shipmentCostInvoiceDTO.getInvoiceDate());
            InvoiceTypeDTO.Info invoiceTypeDTO = invoiceTypeService.get(shipmentCostInvoiceDTO.getInvoiceTypeId());
            ContractDTO.Info contractDTO = contractService.get(shipmentCostInvoiceDTO.getContractId());

            shipmentCostInvoiceDTO.setInvoiceNo(invoiceNoGenerator.createInvoiceNo(
                    invoiceTypeDTO.getTitle(),
                    calendar.get(Calendar.YEAR),
                    calendar.get(Calendar.MONTH) + 1,
                    contractDTO.getMaterial().getAbbreviation(),
                    contractDTO.getContractNo()));
        }

        return shipmentCostInvoiceDTO;
    }*/

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ShipmentCostInvoiceDTO.Info update(Long id, ShipmentCostInvoiceDTO.Update request) {

        request.getShipmentCostInvoiceDetails().forEach(item -> item.setShipmentCostInvoiceId(request.getId()));
        ShipmentCostInvoice shipmentCostInvoice = repository.findById(id).orElseThrow(() -> new NotFoundException(ShipmentCostInvoice.class));

        try {
            updateDetail(request, shipmentCostInvoice);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {
            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("shipment-cost-invoice.exception.update", null, locale));
        }

        ShipmentCostInvoice updating = new ShipmentCostInvoice();
        modelMapper.map(shipmentCostInvoice, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        return save(updating);

    }

    private void updateDetail(ShipmentCostInvoiceDTO.Update request, ShipmentCostInvoice shipmentCostInvoice) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<ShipmentCostInvoiceDetailDTO.Create> shipmentCostInvoiceDetail4Insert = new ArrayList<>();
        List<ShipmentCostInvoiceDetailDTO.Update> shipmentCostInvoiceDetail4Update = new ArrayList<>();
        ShipmentCostInvoiceDetailDTO.Delete shipmentCostInvoiceDetail4Delete = new ShipmentCostInvoiceDetailDTO.Delete();

        updateUtil.fill(ShipmentCostInvoiceDetail.class, shipmentCostInvoice.getShipmentCostInvoiceDetails(), ShipmentCostInvoiceDetailDTO.Info.class, request.getShipmentCostInvoiceDetails(), ShipmentCostInvoiceDetailDTO.Create.class, shipmentCostInvoiceDetail4Insert, ShipmentCostInvoiceDetailDTO.Update.class, shipmentCostInvoiceDetail4Update, shipmentCostInvoiceDetail4Delete);

        if (!shipmentCostInvoiceDetail4Insert.isEmpty())
            shipmentCostInvoiceDetailService.createAll(shipmentCostInvoiceDetail4Insert);
        if (!shipmentCostInvoiceDetail4Update.isEmpty())
            shipmentCostInvoiceDetailService.updateAll(shipmentCostInvoiceDetail4Update);
        if (!shipmentCostInvoiceDetail4Delete.getIds().isEmpty())
            shipmentCostInvoiceDetailService.deleteAll(shipmentCostInvoiceDetail4Delete);

    }
}
