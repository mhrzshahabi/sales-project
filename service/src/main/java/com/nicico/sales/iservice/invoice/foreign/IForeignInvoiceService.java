package com.nicico.sales.iservice.invoice.foreign;

import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;

import java.util.List;

public interface IForeignInvoiceService extends IGenericService<ForeignInvoice, Long, ForeignInvoiceDTO.Create, ForeignInvoiceDTO.Info, ForeignInvoiceDTO.Update, ForeignInvoiceDTO.Delete> {

    List<ForeignInvoiceDTO.Info> getByShipment(Long invoiceTypeId, Long shipmentId, Long currencyId);

    ContractDetailDataDTO.Info getContractDetailData(Long contractId);
}
