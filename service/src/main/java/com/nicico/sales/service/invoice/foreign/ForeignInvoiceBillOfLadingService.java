package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceBillOfLandingDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceBillOfLadingService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceBillOfLading;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceBillOfLadingService extends GenericService<ForeignInvoiceBillOfLading, Long, ForeignInvoiceBillOfLandingDTO.Create, ForeignInvoiceBillOfLandingDTO.Info, ForeignInvoiceBillOfLandingDTO.Update, ForeignInvoiceBillOfLandingDTO.Delete> implements IForeignInvoiceBillOfLadingService {
}
