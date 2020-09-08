package com.nicico.sales.service.invoice.foreign;

import com.ghasemkiani.util.icu.PersianCalendar;
import com.ibm.icu.util.Calendar;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InvoiceTypeDTO;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.dto.invoice.foreign.*;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceDAO;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.service.InvoiceTypeService;
import com.nicico.sales.service.contract.ContractService2;
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
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceService extends GenericService<ForeignInvoice, Long, ForeignInvoiceDTO.Create, ForeignInvoiceDTO.Info, ForeignInvoiceDTO.Update, ForeignInvoiceDTO.Delete> implements IForeignInvoiceService {

    private final UpdateUtil updateUtil;
    private final InvoiceNoGenerator invoiceNoGenerator;
    private final ResourceBundleMessageSource messageSource;
    private final ContractService2 contractService;
    private final InvoiceTypeService invoiceTypeService;
    private final ForeignInvoiceItemService foreignInvoiceItemService;
    private final ForeignInvoicePaymentService foreignInvoicePaymentService;
    private final ForeignInvoiceItemDetailService foreignInvoiceItemDetailService;
    private final ForeignInvoiceBillOfLadingService foreignInvoiceBillOfLadingService;

    @Override
    @Transactional
    @Action(ActionType.Get)
    public List<ForeignInvoiceDTO.Info> getByShipment(Long invoiceTypeId, Long shipmentId, Long currencyId) {

        List<ForeignInvoice> allByContractIdAndInvoiceTypeId = ((ForeignInvoiceDAO) repository).findAllByShipmentIdAndInvoiceTypeId(shipmentId, invoiceTypeId);
        final List<ForeignInvoice> foreignInvoicePI = allByContractIdAndInvoiceTypeId.stream().
                filter(q -> q.getCurrencyId().longValue() != currencyId && (q.getConversionRef() == null || q.getConversionRef().getUnitToId().longValue() != currencyId)).collect(Collectors.toList());

        if (foreignInvoicePI.size() != 0) {

            Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage("", null, locale);
            throw new SalesException2(ErrorType.BadRequest, null, message);
        }

        return modelMapper.map(allByContractIdAndInvoiceTypeId, new TypeToken<List<ForeignInvoiceDTO.Info>>() {
        }.getType());
    }

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ForeignInvoiceDTO.Info create(ForeignInvoiceDTO.Create request) {

        PersianCalendar calendar = new PersianCalendar(request.getDate());
        ContractDTO2.Info contract = contractService.get(request.getContractId());
        InvoiceTypeDTO.Info invoiceType = invoiceTypeService.get(request.getInvoiceTypeId());
        request.setNo(invoiceNoGenerator.createInvoiceNo(invoiceType.getTitle(), calendar.get(Calendar.YEAR) % 100, calendar.get(Calendar.MONTH) + 1, contract.getMaterial().getAbbreviation(), contract.getNo()));

        ForeignInvoiceDTO.Info foreignInvoice = super.create(request);

        request.getForeignInvoiceItems().forEach(item -> {

            ForeignInvoiceItemDTO.Create foreignInvoiceItemCreate = modelMapper.map(item, ForeignInvoiceItemDTO.Create.class);
            foreignInvoiceItemCreate.setForeignInvoiceId(foreignInvoice.getId());
            ForeignInvoiceItemDTO.Info foreignInvoiceItem = foreignInvoiceItemService.create(foreignInvoiceItemCreate);
            item.getForeignInvoiceItemDetails().forEach(detail -> {

                ForeignInvoiceItemDetailDTO.Create foreignInvoiceItemDetailCreate = modelMapper.map(detail, ForeignInvoiceItemDetailDTO.Create.class);
                foreignInvoiceItemDetailCreate.setForeignInvoiceItemId(foreignInvoiceItem.getId());
                foreignInvoiceItemDetailService.create(foreignInvoiceItemDetailCreate);
            });
        });

        request.getForeignInvoicePayments().forEach(item -> item.setForeignInvoiceId(foreignInvoice.getId()));
        foreignInvoicePaymentService.createAll(modelMapper.map(request.getForeignInvoicePayments(), new TypeToken<List<ForeignInvoicePaymentDTO.Create>>() {
        }.getType()));

        request.getBillLadingIds().forEach(item -> {
            ForeignInvoiceBillOfLandingDTO.Create foreignInvoiceBillOfLanding = new ForeignInvoiceBillOfLandingDTO.Create();
            foreignInvoiceBillOfLanding.setBillOfLandingId(item);
            foreignInvoiceBillOfLanding.setForeignInvoiceId(foreignInvoice.getId());
            foreignInvoiceBillOfLadingService.create(foreignInvoiceBillOfLanding);
        });

        return foreignInvoice;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ForeignInvoiceDTO.Info update(Long id, ForeignInvoiceDTO.Update request) {

        request.getForeignInvoiceItems().forEach(item -> item.setForeignInvoiceId(request.getId()));
        request.getForeignInvoicePayments().forEach(item -> item.setForeignInvoiceId(request.getId()));
        request.getBillLadingIds().forEach(item -> {
            ForeignInvoiceBillOfLandingDTO.Update foreignInvoiceBillOfLanding = new ForeignInvoiceBillOfLandingDTO.Update();
            foreignInvoiceBillOfLanding.setBillOfLandingId((item));
            foreignInvoiceBillOfLanding.setForeignInvoiceId(request.getId());
            foreignInvoiceBillOfLadingService.update(foreignInvoiceBillOfLanding);
        });

        ForeignInvoice foreignInvoice = repository.findById(id).orElseThrow(() -> new NotFoundException(ForeignInvoice.class));

        updateForeignInvoiceItems(request, foreignInvoice);
        updateForeignInvoicePayments(request, foreignInvoice);

        ForeignInvoice updating = new ForeignInvoice();
        modelMapper.map(foreignInvoice, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        return save(updating);
    }

    private void updateForeignInvoiceItems(ForeignInvoiceDTO.Update request, ForeignInvoice foreignInvoice) {

        List<ForeignInvoiceItemDTO.Create> foreignInvoiceItem4Insert = new ArrayList<>();
        List<ForeignInvoiceItemDTO.Update> foreignInvoiceItem4Update = new ArrayList<>();
        ForeignInvoiceItemDTO.Delete foreignInvoiceItem4Delete = new ForeignInvoiceItemDTO.Delete();

//        updateUtil.fill(ForeignInvoice.class,
//                foreignInvoice.getForeignInvoiceItems(),
//                ForeignInvoiceItemDTO.Info.class,
//                request.getForeignInvoiceItems(),
//                ForeignInvoiceItemDTO.Create.class,
//                foreignInvoiceItem4Insert,
//                ForeignInvoiceItemDTO.Update.class,
//                foreignInvoiceItem4Update,
//                foreignInvoiceItem4Delete);

        if (!foreignInvoiceItem4Insert.isEmpty()) foreignInvoiceItemService.createAll(foreignInvoiceItem4Insert);
        if (!foreignInvoiceItem4Update.isEmpty()) foreignInvoiceItemService.updateAll(foreignInvoiceItem4Update);
        if (!foreignInvoiceItem4Delete.getIds().isEmpty())
            foreignInvoiceItemService.deleteAll(foreignInvoiceItem4Delete);
    }

    private void updateForeignInvoicePayments(ForeignInvoiceDTO.Update request, ForeignInvoice foreignInvoice) {

        List<ForeignInvoicePaymentDTO.Create> foreignInvoicePayment4Insert = new ArrayList<>();
        List<ForeignInvoicePaymentDTO.Update> foreignInvoicePayment4Update = new ArrayList<>();
        ForeignInvoicePaymentDTO.Delete foreignInvoicePayment4Delete = new ForeignInvoicePaymentDTO.Delete();

//        updateUtil.fill(ForeignInvoicePayment.class,
//                foreignInvoice.getForeignInvoicePayments(),
//                ForeignInvoicePaymentDTO.Info.class,
//                request.getForeignInvoicePayments(),
//                ForeignInvoicePaymentDTO.Create.class,
//                foreignInvoicePayment4Insert,
//                ForeignInvoicePaymentDTO.Update.class,
//                foreignInvoicePayment4Update,
//                foreignInvoicePayment4Delete);

        if (!foreignInvoicePayment4Insert.isEmpty())
            foreignInvoicePaymentService.createAll(foreignInvoicePayment4Insert);
        if (!foreignInvoicePayment4Update.isEmpty())
            foreignInvoicePaymentService.updateAll(foreignInvoicePayment4Update);
        if (!foreignInvoicePayment4Delete.getIds().isEmpty())
            foreignInvoicePaymentService.deleteAll(foreignInvoicePayment4Delete);
    }

    @Override
    @Transactional
    @Action(ActionType.Delete)
    public void delete(Long aLong) {
    }

    @Override
    @Transactional
    @Action(ActionType.DeleteAll)
    public void deleteAll(ForeignInvoiceDTO.Delete request) {
    }
}
