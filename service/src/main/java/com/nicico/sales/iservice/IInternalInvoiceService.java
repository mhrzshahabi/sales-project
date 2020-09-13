package com.nicico.sales.iservice;

import com.nicico.sales.dto.AccountingDTO;

public interface IInternalInvoiceService {

	void sendInvoice(String invoiceId, AccountingDTO.DocumentCreateRq request);
}
