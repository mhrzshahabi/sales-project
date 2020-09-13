package com.nicico.sales.service;

import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.IInternalInvoiceService;
import com.nicico.sales.model.entities.base.ViewInternalInvoice;
import com.nicico.sales.repository.InternalInvoiceDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class InternalInvoiceService implements IInternalInvoiceService {


	private final ModelMapper modelMapper;

	private final InternalInvoiceDAO internalInvoiceDAO;

	private final IAccountingApiService accountingApiService;

	// ------------------------------

	@Override
	@Transactional(readOnly = true)
	public void sendInvoice(String invoiceId, AccountingDTO.DocumentCreateRq request) {
		final ViewInternalInvoice internalInvoice = internalInvoiceDAO.findById(invoiceId)
				.orElseThrow(() -> new SalesException2(ErrorType.NotFound, "id", "شناسه موجودیت یافت نشد."));
	}
}
