package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceService extends GenericService<ForeignInvoice, Long, ForeignInvoiceDTO.Create, ForeignInvoiceDTO.Info, ForeignInvoiceDTO.Update, ForeignInvoiceDTO.Delete> implements IForeignInvoiceService {
}
