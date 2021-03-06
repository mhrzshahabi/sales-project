package com.nicico.sales.service;

import com.nicico.copper.common.domain.i18n.CaptionFactory;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.IInternalInvoiceService;
import com.nicico.sales.model.entities.base.InternalInvoiceDocument;
import com.nicico.sales.model.entities.base.ViewInternalInvoiceDocument;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.repository.InternalInvoiceDAO;
import com.nicico.sales.repository.InternalInvoiceDocumentDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
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
	private final ResourceBundleMessageSource messageSource;
	private final InternalInvoiceDAO internalInvoiceDAO;
	private final InternalInvoiceDocumentDAO internalInvoiceDocumentDAO;

	private final IAccountingApiService accountingApiService;

	// ------------------------------

	@Override
	@Transactional
	public String sendInvoice(String invoiceId, AccountingDTO.DocumentCreateRq request) {
		final ViewInternalInvoiceDocument internalInvoice = internalInvoiceDAO.findById(invoiceId)
				.orElseThrow(() -> new SalesException2(ErrorType.NotFound, "id", "شناسه موجودیت یافت نشد."));

		final Map<String, Object> result = accountingApiService.sendInvoice("sales internal invoice", request, Collections.singletonList(internalInvoice));

		if (result.containsKey("docId")) {
			final Optional<InternalInvoiceDocument> internalInvoiceDocumentOpt = internalInvoiceDocumentDAO.findById(invoiceId);

			if (internalInvoiceDocumentOpt.isPresent()) {
				final InternalInvoiceDocument update = new InternalInvoiceDocument();
				modelMapper.map(internalInvoiceDocumentOpt.get(), update);
				update.setDocumentId(String.valueOf(result.get("docId")))
						.setEStatus(Collections.singletonList(EStatus.SendToAcc));

				internalInvoiceDocumentDAO.saveAndFlush(update);
			} else {
				final InternalInvoiceDocument save = new InternalInvoiceDocument()
						.setInvoiceId(invoiceId)
						.setDocumentId(String.valueOf(result.get("docId")));

				save.setEStatus(Collections.singletonList(EStatus.SendToAcc));

				internalInvoiceDocumentDAO.saveAndFlush(save);
			}

			String message = messageSource.getMessage("accounting.create.document.number",
					new Object[]{String.valueOf(result.get("docId"))}, LocaleContextHolder.getLocale());

			return message + "@" + result.get("docId");
		} else {
			log.error("InternalInvoiceService.sendInvoice: invoiceId [{}]", invoiceId);
			new SalesException2(ErrorType.NotFound, "id", CaptionFactory.getLabel("global.error"));
		}

		return "";
	}

	@Override
	@Transactional
	public void updateInvoiceIdsStatus(String systemName, AccountingDTO.DocumentStatusRq request) {
		final Map<String, String> result = accountingApiService.getInvoiceStatus(systemName, request.getInvoiceIds());

		request.getInvoiceIds().forEach(invoiceId -> {
			final Optional<InternalInvoiceDocument> internalInvoiceDocumentOpt = internalInvoiceDocumentDAO.findById(invoiceId);
			if (internalInvoiceDocumentOpt.isPresent()) {
				if (result.containsKey(invoiceId)) {
					internalInvoiceDocumentOpt.get().setDocumentId(result.get(invoiceId));
				} else {
					internalInvoiceDocumentOpt.get().setDocumentId(null)
							.setEStatus(Collections.singletonList(EStatus.RemoveFromAcc));
				}

				internalInvoiceDocumentDAO.saveAndFlush(internalInvoiceDocumentOpt.get());
			}
		});
	}
}
