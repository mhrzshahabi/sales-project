package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceDAO;
import com.nicico.sales.service.GenericService;
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

    private final ResourceBundleMessageSource messageSource;

    @Override
    @Transactional
    public List<ForeignInvoiceDTO.Info> getByContract(Long invoiceTypeId, Long contractId, Long currencyId) {

        List<ForeignInvoice> allByContractIdAndInvoiceTypeId = ((ForeignInvoiceDAO) repository).findAllByContractIdAndInvoiceTypeId(contractId, invoiceTypeId);
        final List<ForeignInvoice> foreignInvoicePI = allByContractIdAndInvoiceTypeId.stream().
                filter(q -> q.getUnitId().longValue() != currencyId && (q.getConversionRef() == null || q.getConversionRef().getUnitToId().longValue() != currencyId))
                .collect(Collectors.toList());

        if (foreignInvoicePI.size() != 0) {

            Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage("", null, locale);
            throw new SalesException2(ErrorType.BadRequest, null, message);
        }

        return modelMapper.map(allByContractIdAndInvoiceTypeId, new TypeToken<List<ForeignInvoiceDTO.Info>>() {
        }.getType());
    }
}
