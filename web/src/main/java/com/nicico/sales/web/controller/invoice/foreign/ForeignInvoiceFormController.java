package com.nicico.sales.web.controller.invoice.foreign;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceBillOfLandingDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItemDetail;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoicePayment;
import com.nicico.sales.model.enumeration.*;
import com.nicico.sales.utility.SecurityChecker;
import com.nicico.sales.web.controller.utility.WordUtil;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/foreign-invoice")
public class ForeignInvoiceFormController {

    private final WordUtil wordUtil;
    private final ObjectMapper objectMapper;
    private final IForeignInvoiceService foreignInvoiceService;

    @RequestMapping("/show-form")
    public String show(HttpServletRequest request) throws JsonProcessingException {

        SecurityChecker.addEntityPermissionToRequest(request,
                ForeignInvoice.class,
                ForeignInvoicePayment.class,
                ForeignInvoiceItem.class,
                ForeignInvoiceItemDetail.class);

        Map<String, String> rateReferences = new HashMap<>();
        for (RateReference value : RateReference.values()) rateReferences.put(value.name(), value.name());
        request.setAttribute("Enum_RateReference", objectMapper.writeValueAsString(rateReferences));

        Map<String, String> deductionTypes = new HashMap<>();
        for (DeductionType value : DeductionType.values()) deductionTypes.put(value.name(), value.name());
        request.setAttribute("Enum_DeductionType", objectMapper.writeValueAsString(deductionTypes));

        Map<String, String> currencyUnits = new HashMap<>();
        for (CategoryUnit value : CategoryUnit.values()) currencyUnits.put(value.name(), value.name());
        request.setAttribute("Enum_CategoryUnit", objectMapper.writeValueAsString(currencyUnits));

        Map<String, String> commercialRoles = new HashMap<>();
        for (CommercialRole value : CommercialRole.values()) commercialRoles.put(value.name(), value.name());
        request.setAttribute("Enum_CommercialRole", objectMapper.writeValueAsString(commercialRoles));

        Map<String, String> mileStone = new HashMap<>();
        for (InspectionReportMilestone value : InspectionReportMilestone.values())
            mileStone.put(value.name(), value.name());
        request.setAttribute("Enum_MileStone", objectMapper.writeValueAsString(mileStone));

        return "invoice/foreign/foreign-invoice";
    }

    @RequestMapping("/print/{foreignInvoiceId}")
    public void printDocx(HttpServletResponse response, @PathVariable Long foreignInvoiceId) throws IOException {

        ForeignInvoiceDTO.Info foreignInvoice = foreignInvoiceService.get(foreignInvoiceId);

        InputStream stream = new ClassPathResource("reports/word/FI_CONCENTRATE.docx").getInputStream();
        XWPFDocument doc = new XWPFDocument(stream);
        DateFormat dtf = new SimpleDateFormat("yyyy/MM/dd");
        // replace data
        wordUtil.replacePOI(doc, "INVOICE_TYPE_TITLE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "FOREIGN_INVOICE_NO", foreignInvoice.getNo());
        wordUtil.replacePOI(doc, "FOREIGN_INVOICE_DATE", foreignInvoice.getDate().toString());
        wordUtil.replacePOI(doc, "CONTRACT_NO", foreignInvoice.getShipment().getContractShipment().getContract().getNo());
        wordUtil.replacePOI(doc, "BUYER_NAME_EN", foreignInvoice.getBuyer().getNameEN());
        wordUtil.replacePOI(doc, "BUYER_ADDRESS", foreignInvoice.getBuyer().getAddress());
        wordUtil.replacePOI(doc, "BUYER_PHONE", foreignInvoice.getBuyer().getPhone());
        wordUtil.replacePOI(doc, "MATERIAL_DESC_EN", foreignInvoice.getShipment().getMaterial().getDescEN());
        wordUtil.replacePOI(doc, "VESSEL_NAME", foreignInvoice.getShipment().getVessel().getName());
        List<ForeignInvoiceBillOfLandingDTO.Info> billOfLanding = foreignInvoice.getBillLadings();
        billOfLanding.forEach(q -> {
            wordUtil.replacePOI(doc, "SWITCH_DOC_NO", q.getBillOfLanding().getSwitchDocumentNo());
            wordUtil.replacePOI(doc, "NICICO_DOC_NO", q.getBillOfLanding().getDocumentNo());
            wordUtil.replacePOI(doc, "PORT_OF_LOADING", q.getBillOfLanding().getPortOfLoading().getPort());
            wordUtil.replacePOI(doc, "PORT_OF_DISCHARGE", q.getBillOfLanding().getPortOfDischarge().getPort());
        });
        List<ForeignInvoiceItemDTO.Info> foreignInvoiceItems = foreignInvoice.getForeignInvoiceItems();
        foreignInvoiceItems.forEach(q -> {
            wordUtil.replacePOI(doc, "WEIGHT_GW", q.getWeightGW().toString());
            wordUtil.replacePOI(doc, "WEIGHT_ND", q.getWeightND().toString());
          //  wordUtil.replacePOI(doc, "MOISTURE_WEIGHT", q.getWeightND().toString());
        });
        wordUtil.replacePOI(doc, "TOTAL_GROSS", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "INCOTERM_TITLE_EN", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "INCOTERM_VERSION", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "CU_PRICE_BASE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AG_PRICE_BASE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AU_PRICE_BASE", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "CU_ASSAY", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AG_ASSAY", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AU_ASSAY", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "WEIGHT_GW", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "MOISTURE_WEIGHT", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "WEIGHT_ND", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "CU_CALCULATION", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AG_CALCULATION", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AU_CALCULATION", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "CU_DEDUCTION_TYPE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AG_DEDUCTION_TYPE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AU_DEDUCTION_TYPE", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "CU_DEDUCTION_VALUE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AG_DEDUCTION_VALUE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AU_DEDUCTION_VALUE", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "F_CU_ASSAY", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "F_AG_ASSAY", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "F_AU_ASSAY", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "UNIT_PRICE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "UNIT_COST", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "PURE", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "RC_TIC", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "RC_CU", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "RC_AG", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "RC_AU", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "CU_RC_BASE_PRICE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AG_RC_BASE_PRICE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "AU_RC_BASE_PRICE", foreignInvoice.getInvoiceType().getTitle());

        wordUtil.replacePOI(doc, "SUM_FI_PRICE", foreignInvoice.getInvoiceType().getTitle());
        wordUtil.replacePOI(doc, "CONVERSION_SUM_PRICE", foreignInvoice.getConversionSumPrice().toString());
      //  wordUtil.replacePOI(doc, "CONVERSION_VALUE", foreignInvoice.getcon);
        wordUtil.replacePOI(doc, "CONVERSION_REFRENCE", foreignInvoice.getConversionRef().toString());

        wordUtil.replacePOI(doc, "CONVERSION_DATE ", dtf.format(foreignInvoice.getConversionDate()));
        wordUtil.replacePOI(doc, "CONVERSION_SUM_PRICE_TEXT", foreignInvoice.getConversionSumPriceText());
        //  wordUtil.replacePOI(doc, "MARKETING_MANAGER", foreignInvoice.getInvoiceType().getTitle());


        response.setHeader("Content-Disposition", "attachment; filename=FI_CONCENTRATE");
        response.setContentType("application/vnd.ms-word");
        ServletOutputStream out = response.getOutputStream();
        doc.write(out);
        out.flush();
    }
}
