package com.nicico.sales.service;

import com.nicico.copper.common.domain.i18n.CaptionFactory;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.IForeignInvoiceDocService;
import com.nicico.sales.model.entities.base.ViewForeignInvoiceDocument;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.repository.ForeignInvoiceDocDAO;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class ForeignInvoiceDocService implements IForeignInvoiceDocService {

	private final ModelMapper modelMapper;
	private final ResourceBundleMessageSource messageSource;
	private final ForeignInvoiceDocDAO foreignInvoiceDocDAO;
	private final ForeignInvoiceDAO foreignInvoiceDAO;

	private final IAccountingApiService accountingApiService;

	// ------------------------------

	@Override
	@Transactional
	public String sendInvoice(Long invoiceId, AccountingDTO.DocumentCreateRq request) {
		final ForeignInvoice foreignInvoice = foreignInvoiceDAO.findById(invoiceId)
				.orElseThrow(() -> new SalesException2(ErrorType.NotFound, "id", "شناسه موجودیت یافت نشد."));

		if (!foreignInvoice.getEStatus().contains(EStatus.Final))
			throw new SalesException2(ErrorType.FinalRecord, "id", "موجودیت تایید نهایی نشده است!");

		final List<ViewForeignInvoiceDocument> foreignInvoiceDocuments = foreignInvoiceDocDAO.findAllByIdFiId(invoiceId);
		final List<Object> objects = new ArrayList<>(foreignInvoiceDocuments);

		final Map<String, Object> result = accountingApiService.sendInvoice("sales foreign invoice", request, objects);

		if (result.containsKey("docId")) {
			final ForeignInvoice update = new ForeignInvoice();
			modelMapper.map(foreignInvoice, update);
			update.setDocumentId(String.valueOf(result.get("docId")));

			final List<EStatus> eStatus = foreignInvoice.getEStatus();
			eStatus.remove(EStatus.RemoveFromAcc);
			eStatus.add(EStatus.SendToAcc);
			update.setEStatus(eStatus);

			foreignInvoiceDAO.saveAndFlush(update);

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
		final Map<String, String> result = accountingApiService.getInvoiceStatus(systemName, request.getInvoiceIds());

		request.getInvoiceIds().forEach(invoiceId -> {
			final Optional<ForeignInvoice> foreignInvoiceOpt = foreignInvoiceDAO.findById(Long.valueOf(invoiceId));
			if (foreignInvoiceOpt.isPresent()) {
				if (result.containsKey(invoiceId)) {
					foreignInvoiceOpt.get().setDocumentId(result.get(invoiceId));
				} else if(!StringUtils.isEmpty(foreignInvoiceOpt.get().getDocumentId())) {
					foreignInvoiceOpt.get().setDocumentId(null);

					final List<EStatus> eStatus = foreignInvoiceOpt.get().getEStatus();
					eStatus.remove(EStatus.SendToAcc);
					eStatus.add(EStatus.RemoveFromAcc);
					foreignInvoiceOpt.get().setEStatus(eStatus);
				}

				foreignInvoiceDAO.saveAndFlush(foreignInvoiceOpt.get());
			}
		});
	}
}
