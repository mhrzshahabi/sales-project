package com.nicico.sales.iservice.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceBillOfLandingDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceBillOfLading;

public interface IForeignInvoiceBillOfLadingService extends IGenericService <ForeignInvoiceBillOfLading, Long, ForeignInvoiceBillOfLandingDTO.Create, ForeignInvoiceBillOfLandingDTO.Info, ForeignInvoiceBillOfLandingDTO.Update, ForeignInvoiceBillOfLandingDTO.Delete> {

}
