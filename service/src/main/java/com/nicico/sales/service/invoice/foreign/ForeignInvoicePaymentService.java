package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ForeignInvoicePaymentDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoicePaymentService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoicePayment;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ForeignInvoicePaymentService extends GenericService<ForeignInvoicePayment, Long, ForeignInvoicePaymentDTO.Create, ForeignInvoicePaymentDTO.Info, ForeignInvoicePaymentDTO.Update, ForeignInvoicePaymentDTO.Delete> implements IForeignInvoicePaymentService {
}
