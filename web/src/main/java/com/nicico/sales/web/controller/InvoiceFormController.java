package com.nicico.sales.web.controller;

import com.nicico.copper.common.domain.ConstantVARs;
import com.nicico.copper.common.dto.grid.GridResponse;
import com.nicico.copper.common.dto.search.EOperator;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.copper.core.util.report.ReportUtil;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.dto.InvoiceItemDTO;
import com.nicico.sales.iservice.IContractService;
import com.nicico.sales.iservice.IInvoiceItemService;
import com.nicico.sales.service.InvoiceService;
import com.nicico.sales.service.ShipmentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/invoice")
public class InvoiceFormController {

    private final ReportUtil reportUtil;
    private final IInvoiceItemService invoiceItemService;
    private final IContractService contractService;
    private final InvoiceService invoiceService;
    private final ShipmentService shipmentService;

    @RequestMapping("/showForm")
    public String showInvoice() {
        return "shipment/invoice";
    }

    @RequestMapping("/showForm/{shipmentId}/{invoiceId}/{type}/{contractId}")
    public String showInvoiceMolybdenum(HttpServletRequest req, @PathVariable String shipmentId, @PathVariable String invoiceId, @PathVariable String type, @PathVariable String contractId) {

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

            final SearchDTO.SearchRs<InvoiceItemDTO.Info> responseItem = invoiceItemService.search(request);

            gridResponseItem.setData(responseItem.getList());
            gridResponseItem.setStartRow(0).setEndRow(responseItem.getTotalCount().intValue()).setTotalRows(responseItem.getTotalCount().intValue());
        }
        req.getSession().setAttribute("shipmentId", shipmentId);
        req.getSession().setAttribute("invoiceId", invoiceId);
        req.getSession().setAttribute("gridResponseItem", gridResponseItem);

        if (contract.getContactBySellerId() != null) {
            req.getSession().setAttribute("sellerId", contract.getContactBySellerId());
            req.getSession().setAttribute("sellerName", contract.getContactBySeller().getNameEN());
        }
        if (contract.getContactId() != null) {
            req.getSession().setAttribute("BuyerId", contract.getContactId());
            req.getSession().setAttribute("BuyerName", contract.getContact().getNameEN());
        }
        if (contract.getContactBySellerAgentId() != null) {
            req.getSession().setAttribute("sellerAgentId", contract.getContactBySellerAgentId());
            req.getSession().setAttribute("sellerAgentName", contract.getContactBySellerAgent().getNameEN());
        }
        if (contract.getContactByBuyerAgentId() != null) {
            req.getSession().setAttribute("BuyerAgentId", contract.getContactByBuyerAgentId());
            req.getSession().setAttribute("BuyerAgentName", contract.getContactByBuyerAgent().getNameEN());
        }

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

    @RequestMapping("/print/{type}/{rowId}")
    public void printInvoice(HttpServletResponse response, @PathVariable String type, @PathVariable String rowId) throws Exception {
        Map<String, Object> params = new HashMap<>();
        params.put("ID", rowId);
        params.put(ConstantVARs.REPORT_TYPE, type);
        Long shipmentId = invoiceService.get(Long.valueOf(rowId)).getShipmentId();
        String description = shipmentService.get(shipmentId).getMaterial().getDescl();
        if (description.toLowerCase().contains("mol")) {
            reportUtil.export("/reports/Mo_Ox.jasper", params, response);
        } else if (description.toLowerCase().contains("cat")) {
            reportUtil.export("/reports/CAD.jasper", params, response);
        } else if (description.toLowerCase().contains("conc")) {
            reportUtil.export("/reports/Conc.jasper", params, response);
        }
    }
}
