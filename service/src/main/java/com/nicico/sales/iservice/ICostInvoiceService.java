package com.nicico.sales.iservice;

import com.nicico.sales.dto.AccountingDTO;

public interface ICostInvoiceService {

	String sendInvoice(Long invoiceId, AccountingDTO.DocumentCreateRq request);

	void updateInvoiceIdsStatus(String systemName, AccountingDTO.DocumentStatusRq request);
}
