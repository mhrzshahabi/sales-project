package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.dto.InvoiceItemDTO;
import com.nicico.sales.dto.InvoiceMolybdenumDTO;
import com.nicico.sales.iservice.IContractService;
import com.nicico.sales.iservice.IInvoiceItemService;
import com.nicico.sales.iservice.IInvoiceMolybdenumService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoice")
public class InvoiceFormController {

	@RequestMapping("/showForm")
	public String showInvoice() {
		return "shipment/invoice";
	}
	private final ReportUtil reportUtil;
	private final IInvoiceMolybdenumService invoiceMolybdenumService;
	private final IInvoiceItemService invoiceItemService;
	private final IContractService contractService;

	@RequestMapping("/showForm/{shipmentId}/{invoiceId}/{type}/{contractId}")
	public String showInvoiceMolybdenum(HttpServletRequest req, @PathVariable String shipmentId, @PathVariable String invoiceId, @PathVariable String type, @PathVariable String contractId) {

		String cr = "{ \"operator\":\"and\", \"criteria\" : [  { \"fieldName\":\"invoiceId\", \"operator\":\"equals\", \"value\":\"22222\"  }\t] }";
		final GridResponse<InvoiceMolybdenumDTO.Info> gridResponse = new GridResponse();
		final GridResponse<InvoiceItemDTO.Info> gridResponseItem = new GridResponse();
		ContractDTO.Info contract = contractService.get(new Long(contractId));
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
		req.getSession().setAttribute("shipmentId", shipmentId);
		req.getSession().setAttribute("invoiceId", invoiceId);
		req.getSession().setAttribute("gridResponse", gridResponse);
		req.getSession().setAttribute("gridResponseItem", gridResponseItem);
		/*req.getSession().setAttribute("sellerId", contract.getContactBySellerId());
		req.getSession().setAttribute("sellerName", contract.getContactBySeller().getNameEN());
		req.getSession().setAttribute("BuyerId", contract.getContactId());
		req.getSession().setAttribute("BuyerName", contract.getContact().getNameEN());
		req.getSession().setAttribute("sellerAgentId", contract.getContactBySellerAgentId());
		req.getSession().setAttribute("sellerAgentName", contract.getContactBySellerAgent().getNameEN());
		req.getSession().setAttribute("BuyerAgentId", contract.getContactByBuyerAgentId());
		req.getSession().setAttribute("BuyerAgentName", contract.getContactByBuyerAgent().getNameEN());*/

		if (type.equalsIgnoreCase("mol"))
			return "shipment/invoiceMolybdenum";
		else if (type.equalsIgnoreCase("cat")) {
			req.getSession().setAttribute("premium", nvl(contract.getPremium()));
			req.getSession().setAttribute("discount", nvl(contract.getDiscount()));
			return "shipment/invoiceCathodes";
		} else {
			req.getSession().setAttribute("treatCost", nvl(contract.getTreatCost()));
			req.getSession().setAttribute("refinaryCost", nvl(contract.getRefinaryCost()));
			req.getSession().setAttribute("copper", nvl(contract.getCopper()));
			req.getSession().setAttribute("silver", nvl(contract.getSilver()));
			req.getSession().setAttribute("gold", nvl(contract.getGold()));
			return "shipment/invoiceConcentrate";
		}

	}

	<T> String nvl(T f) {
		return f == null ? "0.0" : f.toString();
	}

	@RequestMapping("/print/{type}")
	public void printInvoice(HttpServletResponse response, @PathVariable String type , @RequestParam ("invoice_no") String invoice_no) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("INVOICE_NO",invoice_no);
		params.put(ConstantVARs.REPORT_TYPE, type);
		reportUtil.export("/reports/A4-P1.jasper", params, response);
	}
}
