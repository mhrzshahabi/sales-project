package com.nicico.sales.iservice;

import com.nicico.sales.dto.AccountingDTO;

public interface IInternalInvoiceService {

	String sendInvoice(String invoiceId, AccountingDTO.DocumentCreateRq request);

	void updateInvoiceIdsStatus(String systemName, AccountingDTO.DocumentStatusRq request);
}
