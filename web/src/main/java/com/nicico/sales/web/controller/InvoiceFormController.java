package com.nicico.sales.web.controller;

import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoice")
public class InvoiceFormController {

	@RequestMapping("/showForm")
	public String showInvoice() {
		return "shipment/invoice";
	}

	private final IInvoiceMolybdenumService invoiceMolybdenumService;

	@RequestMapping("/showForm/{shipmentId}/{invoiceId}")
	public String showInvoiceMolybdenum(HttpServletRequest req, @PathVariable String shipmentId, @PathVariable String invoiceId) {

		final GridResponse<InvoiceMolybdenumDTO.Info> gridResponse = new GridResponse();
		if (!invoiceId.equalsIgnoreCase("0")) {
			SearchDTO.CriteriaRq requestCriteriaRq = new SearchDTO.CriteriaRq()
					.setOperator(EOperator.and)
					.setFieldName("invoiceId")
					.setValue(invoiceId);
			final SearchDTO.SearchRq request = new SearchDTO.SearchRq();
			request.setCriteria(requestCriteriaRq);
			request.setSortBy("id");

			final SearchDTO.SearchRs<InvoiceMolybdenumDTO.Info> response = invoiceMolybdenumService.search(request);

			gridResponse.setData(response.getList());
			gridResponse.setStartRow(0).setEndRow(response.getTotalCount().intValue()).setTotalRows(response.getTotalCount().intValue());
		}
		req.getSession().setAttribute("shipmentId",shipmentId);
		req.getSession().setAttribute("invoiceId",invoiceId);
		req.getSession().setAttribute("gridResponse",gridResponse);
		return "shipment/invoiceMolybdenum";
	}

	@RequestMapping("/print/{type}")
	public void printInvoice(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
