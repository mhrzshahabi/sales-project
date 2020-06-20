package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceItemService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceItemService extends GenericService<ForeignInvoiceItem, Long, ForeignInvoiceItemDTO.Create, ForeignInvoiceItemDTO.Info, ForeignInvoiceItemDTO.Update, ForeignInvoiceItemDTO.Delete> implements IForeignInvoiceItemService {
}
