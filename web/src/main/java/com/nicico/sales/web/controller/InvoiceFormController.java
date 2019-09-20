package com.nicico.sales.web.controller;

import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InvoiceItemDTO;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;
import com.nicico.sales.iservice.IInvoiceItemService;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoice")
public class InvoiceFormController {

	@RequestMapping("/showForm")
	public String showInvoice() {
		return "shipment/invoice";
	}

	private final IInvoiceMolybdenumService invoiceMolybdenumService;
	private final IInvoiceItemService invoiceItemService;

	@RequestMapping("/showForm/{shipmentId}/{invoiceId}/{type}")
	public String showInvoiceMolybdenum(HttpServletRequest req, @PathVariable String shipmentId, @PathVariable String invoiceId , @PathVariable String type) {
        String cr="{ \"operator\":\"and\", \"criteria\" : [  { \"fieldName\":\"invoiceId\", \"operator\":\"equals\", \"value\":\"22222\"  }\t] }";
		final GridResponse<InvoiceMolybdenumDTO.Info> gridResponse = new GridResponse();
		final GridResponse<InvoiceItemDTO.Info> gridResponseItem = new GridResponse();

		if (!invoiceId.equals("0")) {
			SearchDTO.CriteriaRq requestCriteriaRq = new SearchDTO.CriteriaRq()
					.setOperator(EOperator.equals)
					.setFieldName("invoiceId")
					.setValue(invoiceId);
			final SearchDTO.SearchRq request = new SearchDTO.SearchRq();
			request.setCriteria(requestCriteriaRq);
			request.setSortBy("id");

			if (type.equalsIgnoreCase("mol")) {

				final SearchDTO.SearchRs<InvoiceMolybdenumDTO.Info> response = invoiceMolybdenumService.search(request);
				gridResponse.setData(response.getList());
				gridResponse.setStartRow(0).setEndRow(response.getTotalCount().intValue()).setTotalRows(response.getTotalCount().intValue());
			}

			final SearchDTO.SearchRs<InvoiceItemDTO.Info> responseItem = invoiceItemService.search(request);

			gridResponseItem.setData(responseItem.getList());
			gridResponseItem.setStartRow(0).setEndRow(responseItem.getTotalCount().intValue()).setTotalRows(responseItem.getTotalCount().intValue());
		} else {
			List<InvoiceMolybdenumDTO.Info> aa = new ArrayList<>();
			gridResponse.setData(aa);
			gridResponse.setStartRow(0).setEndRow(0);
			List<InvoiceItemDTO.Info> aa1 = new ArrayList<>();
			gridResponseItem.setData(aa1);
			gridResponseItem.setStartRow(0).setEndRow(0);
		}
		req.getSession().setAttribute("shipmentId",shipmentId);
		req.getSession().setAttribute("invoiceId",invoiceId);
		req.getSession().setAttribute("gridResponse",gridResponse);
		req.getSession().setAttribute("gridResponseItem",gridResponseItem);
		if (type.equalsIgnoreCase("mol"))
			return "shipment/invoiceMolybdenum";
		else
			return "shipment/invoiceConcentrate";

	}

	@RequestMapping("/print/{type}")
	public void printInvoice(HttpServletResponse response, @PathVariable String type) throws Exception {
	}
}
