package com.nicico.sales.service;

import com.nicico.copper.common.domain.i18n.CaptionFactory;
import com.nicico.sales.dto.AccountingDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAccountingApiService;
import com.nicico.sales.iservice.ICostInvoiceService;
import com.nicico.sales.model.entities.base.ShipmentCostInvoice;
import com.nicico.sales.model.entities.base.ViewCostInvoiceDocument;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.repository.CostInvoiceDAO;
import com.nicico.sales.repository.ShipmentCostInvoiceDAO;
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
public class CostInvoiceService implements ICostInvoiceService {

	private final ModelMapper modelMapper;
	private final ResourceBundleMessageSource messageSource;
	private final CostInvoiceDAO costInvoiceDAO;
	private final ShipmentCostInvoiceDAO shipmentCostInvoiceDAO;

	private final IAccountingApiService accountingApiService;

	// ------------------------------

	@Override
	@Transactional
	public String sendInvoice(Long invoiceId, AccountingDTO.DocumentCreateRq request) {
		final ShipmentCostInvoice shipmentCostInvoice = shipmentCostInvoiceDAO.findById(invoiceId)
				.orElseThrow(() -> new SalesException2(ErrorType.NotFound, "id", "شناسه موجودیت یافت نشد."));

		if (shipmentCostInvoice.getEStatus().contains(EStatus.DeActive))
			throw new SalesException2(ErrorType.DeActiveRecord, "id", "موجودیت غیرفعال شده است!");

		if (!shipmentCostInvoice.getEStatus().contains(EStatus.Final))
			throw new SalesException2(ErrorType.FinalRecord, "id", "موجودیت تایید نهایی نشده است!");

		final List<ViewCostInvoiceDocument> costInvoiceDocuments = costInvoiceDAO.findAllByIdShciId(invoiceId);
		final List<Object> objects = new ArrayList<>(costInvoiceDocuments);

		final Map<String, Object> result = accountingApiService.sendInvoice("sales cost invoice", request, objects);

		if (result.containsKey("docId")) {
			final ShipmentCostInvoice update = new ShipmentCostInvoice();
			modelMapper.map(shipmentCostInvoice, update);
			update.setDocumentId(String.valueOf(result.get("docId")));

			final List<EStatus> eStatus = shipmentCostInvoice.getEStatus();
			eStatus.remove(EStatus.RemoveFromAcc);
			if (!eStatus.contains(EStatus.SendToAcc))
				eStatus.add(EStatus.SendToAcc);
			update.setEStatus(eStatus);

			shipmentCostInvoiceDAO.saveAndFlush(update);

			String message = messageSource.getMessage("accounting.create.document.number",
					new Object[]{String.valueOf(result.get("docId"))}, LocaleContextHolder.getLocale());

			return message + "@" + result.get("docId");
		} else {
			log.error("CostInvoiceService.sendInvoice: invoiceId [{}]", invoiceId);
			new SalesException2(ErrorType.NotFound, "id", CaptionFactory.getLabel("global.error"));
		}

		return "";
	}

	@Override
	@Transactional
	public void updateInvoiceIdsStatus(String systemName, AccountingDTO.DocumentStatusRq request) {
		final Map<String, String> result = accountingApiService.getInvoiceStatus(systemName, request.getInvoiceIds());

		request.getInvoiceIds().forEach(invoiceId -> {
			final Optional<ShipmentCostInvoice> shipmentCostInvoiceOpt = shipmentCostInvoiceDAO.findById(Long.valueOf(invoiceId));
			if (shipmentCostInvoiceOpt.isPresent()) {
				if (result.containsKey(invoiceId)) {
					shipmentCostInvoiceOpt.get().setDocumentId(result.get(invoiceId));
				} else if(!StringUtils.isEmpty(shipmentCostInvoiceOpt.get().getDocumentId())) {
					shipmentCostInvoiceOpt.get().setDocumentId(null);

					final List<EStatus> eStatus = shipmentCostInvoiceOpt.get().getEStatus();
					eStatus.remove(EStatus.SendToAcc);
					if (!eStatus.contains(EStatus.RemoveFromAcc))
						eStatus.add(EStatus.RemoveFromAcc);
					shipmentCostInvoiceOpt.get().setEStatus(eStatus);
				}

				shipmentCostInvoiceDAO.saveAndFlush(shipmentCostInvoiceOpt.get());
			}
		});
	}
}
