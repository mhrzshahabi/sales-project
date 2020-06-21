package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDetailDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceItemDetailService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItemDetail;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceItemDetailService extends GenericService<ForeignInvoiceItemDetail, Long, ForeignInvoiceItemDetailDTO.Create, ForeignInvoiceItemDetailDTO.Info, ForeignInvoiceItemDetailDTO.Update, ForeignInvoiceItemDetailDTO.Delete> implements IForeignInvoiceItemDetailService {
}
