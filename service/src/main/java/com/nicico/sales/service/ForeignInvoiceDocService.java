package com.nicico.sales.service;

import com.nicico.copper.common.domain.i18n.CaptionFactory;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.ICostInvoiceService;
import com.nicico.sales.iservice.IForeignInvoiceDocService;
import com.nicico.sales.model.entities.base.ShipmentCostInvoice;
import com.nicico.sales.model.entities.base.ViewCostInvoiceDocument;
import com.nicico.sales.model.entities.base.ViewForeignInvoiceDocument;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.repository.CostInvoiceDAO;
import com.nicico.sales.repository.ForeignInvoiceDocDAO;
import com.nicico.sales.repository.ShipmentCostInvoiceDAO;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class ForeignInvoiceDocService implements IForeignInvoiceDocService {

	private final ResourceBundleMessageSource messageSource;
	private final ForeignInvoiceDocDAO foreignInvoiceDocDAO;
	private final ForeignInvoiceDAO foreignInvoiceDAO;

	private final IAccountingApiService accountingApiService;

	// ------------------------------

	@Override
	@Transactional
	public String sendInvoice(Long invoiceId, AccountingDTO.DocumentCreateRq request) {
		final List<ViewForeignInvoiceDocument> foreignInvoiceDocuments = foreignInvoiceDocDAO.findAllByIdFiId(invoiceId);

		final List<Object> objects = new ArrayList<>(foreignInvoiceDocuments);

		final Map<String, Object> result = accountingApiService.sendInvoice("sales foreign invoice", request, objects);

		if (result.containsKey("docId")) {
			final Optional<ForeignInvoice> foreignInvoiceOpt = foreignInvoiceDAO.findById(invoiceId);

			/*if (foreignInvoiceOpt.isPresent()) {
				final ForeignInvoice update = new ForeignInvoice();
				modelMapper.map(foreignInvoiceOpt.get(), update);
				update.setDocumentId(String.valueOf(result.get("docId")));

				foreignInvoiceDAO.saveAndFlush(update);
			}*/

			String message = messageSource.getMessage("accounting.create.document.number",
					new Object[]{String.valueOf(result.get("docId"))}, LocaleContextHolder.getLocale());

			return message + "@" + result.get("docId");
		} else {
			log.error("ForeignInvoiceDocService.sendInvoice: invoiceId [{}]", invoiceId);
			new SalesException2(ErrorType.NotFound, "id", CaptionFactory.getLabel("global.error"));
		}

		return "";
	}

	@Override
	@Transactional
	public void updateInvoiceIdsStatus(String systemName, AccountingDTO.DocumentStatusRq request) {
		final Map<String, String> result = accountingApiService.getInvoiceStatus(systemName, request.getDocumentIds());

		/*request.getDocumentIds().forEach(invoiceId -> {
			final Optional<ForeignInvoice> foreignInvoiceOpt = foreignInvoiceDAO.findById(Long.valueOf(invoiceId));
			if (foreignInvoiceOpt.isPresent()) {
				foreignInvoiceOpt.get().setDocumentId(result.getOrDefault(invoiceId, null));

				foreignInvoiceDAO.saveAndFlush(foreignInvoiceOpt.get());
			}
		});*/
	}
}
