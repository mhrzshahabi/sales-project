package com.nicico.sales.service.invoice.foreign;

import com.ghasemkiani.util.icu.PersianCalendar;
import com.ibm.icu.util.Calendar;
import com.nicico.sales.dto.InvoiceTypeDTO;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDetailDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoicePaymentDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceDAO;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.service.InvoiceTypeService;
import com.nicico.sales.service.contract.ContractService2;
import com.nicico.sales.utility.InvoiceNoGenerator;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceService extends GenericService<ForeignInvoice, Long, ForeignInvoiceDTO.Create, ForeignInvoiceDTO.Info, ForeignInvoiceDTO.Update, ForeignInvoiceDTO.Delete> implements IForeignInvoiceService {

    private final InvoiceNoGenerator invoiceNoGenerator;
    private final ResourceBundleMessageSource messageSource;
    private final ContractService2 contractService;
    private final InvoiceTypeService invoiceTypeService;
    private final ForeignInvoiceItemService foreignInvoiceItemService;
    private final ForeignInvoicePaymentService foreignInvoicePaymentService;
    private final ForeignInvoiceItemDetailService foreignInvoiceItemDetailService;

    @Override
    @Transactional
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
    public ForeignInvoiceDTO.Info create(ForeignInvoiceDTO.Create request) {

        PersianCalendar calendar = new PersianCalendar(request.getDate());
        ContractDTO2.Info contract = contractService.get(request.getContractId());
        InvoiceTypeDTO.Info invoiceType = invoiceTypeService.get(request.getInvoiceTypeId());
        request.setNo(invoiceNoGenerator.createInvoiceNo(
            invoiceType.getTitle(),
            calendar.get(Calendar.YEAR) % 100,
            calendar.get(Calendar.MONTH) + 1,
            contract.getMaterial().getAbbreviation(),
            contract.getNo()));

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

        return foreignInvoice;
    }
}
