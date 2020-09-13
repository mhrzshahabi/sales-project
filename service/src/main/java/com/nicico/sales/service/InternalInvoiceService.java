package com.nicico.sales.service;

import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.IInternalInvoiceService;
import com.nicico.sales.model.entities.base.InternalInvoiceDocument;
import com.nicico.sales.model.entities.base.ViewInternalInvoiceDocument;
import com.nicico.sales.repository.InternalInvoiceDAO;
import com.nicico.sales.repository.InternalInvoiceDocumentDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class InternalInvoiceService implements IInternalInvoiceService {

	private final ModelMapper modelMapper;

	private final InternalInvoiceDAO internalInvoiceDAO;
	private final InternalInvoiceDocumentDAO internalInvoiceDocumentDAO;

	private final IAccountingApiService accountingApiService;

	// ------------------------------

	@Override
	@Transactional
	public void sendInvoice(String invoiceId, AccountingDTO.DocumentCreateRq request) {
		final ViewInternalInvoiceDocument internalInvoice = internalInvoiceDAO.findById(invoiceId)
				.orElseThrow(() -> new SalesException2(ErrorType.NotFound, "id", "شناسه موجودیت یافت نشد."));

		final Map<String, Object> result = accountingApiService.sendInvoice(request, Collections.singletonList(internalInvoice));

		if (result.containsKey("docId")) {
			final Optional<InternalInvoiceDocument> internalInvoiceDocumentOpt = internalInvoiceDocumentDAO.findById(invoiceId);

			if (internalInvoiceDocumentOpt.isPresent()) {
				final InternalInvoiceDocument update = new InternalInvoiceDocument();
				modelMapper.map(internalInvoiceDocumentOpt.get(), update);
				update.setDocumentId(String.valueOf(result.get("docId")));

				internalInvoiceDocumentDAO.saveAndFlush(update);
			} else {
				final InternalInvoiceDocument save = new InternalInvoiceDocument()
						.setInvoiceId(invoiceId)
						.setDocumentId(String.valueOf(result.get("docId")));

				internalInvoiceDocumentDAO.saveAndFlush(save);
			}
		} else {
			log.error("InternalInvoiceService.sendInvoice: invoiceId [{}]", invoiceId);
		}
	}
}
