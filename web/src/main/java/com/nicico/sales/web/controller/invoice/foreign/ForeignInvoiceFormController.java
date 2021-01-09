package com.nicico.sales.web.controller.invoice.foreign;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nicico.sales.dto.AssayInspectionTotalValuesDTO;
import com.nicico.sales.dto.CurrencyRateDTO;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceBillOfLandingDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDetailDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.iservice.contract.IContractDetailService;
import com.nicico.sales.iservice.contract.IContractDetailValueService2;
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
import org.modelmapper.ModelMapper;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/foreign-invoice")
public class ForeignInvoiceFormController {

    private final WordUtil wordUtil;
    private final ModelMapper modelMapper;
    private final ObjectMapper objectMapper;

    private final IContractDetailService contractDetailService;
    private final IForeignInvoiceService foreignInvoiceService;
    private final IContractDetailValueService2 contractDetailValueService2;

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

        ForeignInvoiceDTO.HeavyInfo foreignInvoice = foreignInvoiceService.getHeavyInfo(foreignInvoiceId);

        Long contractId = foreignInvoice.getShipment().getContractShipment().getContractId();
        Map<String, List<Object>> deliveryTerms = contractDetailValueService2.get(contractId, EContractDetailTypeCode.DeliveryTerms, EContractDetailValueKey.INCOTERM, true);
        InputStream stream = new ClassPathResource("reports/word/FI_CONCENTRATE.docx").getInputStream();
        XWPFDocument doc = new XWPFDocument(stream);
        DateFormat dtf = new SimpleDateFormat("yyyy/MM/dd");
        SimpleDateFormat month_date = new SimpleDateFormat("MMM yyyy", Locale.ENGLISH);

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

        String sendDate = month_date.format(foreignInvoice.getShipment().getSendDate());
        Map<String, List<Object>> moasDatas = contractDetailValueService2.get(contractId, EContractDetailTypeCode.QuotationalPeriod, EContractDetailValueKey.MOAS, true);
        List<Object> list = moasDatas.get(EContractDetailValueKey.MOAS.name());
        if (list != null && list.size() > 0) {

            String moasValue = ((Map) ((List) list.get(0)).get(0)).get("moasValue").toString();
            wordUtil.replacePOI(doc, "QP_CONTENT", "AVERAGE " + sendDate + "(MOAS" + moasValue + ")");
        }

        List<ForeignInvoiceBillOfLandingDTO.Info> billOfLanding = foreignInvoice.getBillLadings();
        billOfLanding.forEach(q -> {
            wordUtil.replacePOI(doc, "SWITCH_DOC_NO", q.getBillOfLanding().getBillOfLadingSwitch() == null ?
                    null : q.getBillOfLanding().getBillOfLadingSwitch().getDocumentNo());
            wordUtil.replacePOI(doc, "NICICO_DOC_NO", q.getBillOfLanding().getDocumentNo());
            wordUtil.replacePOI(doc, "PORT_OF_LOADING", q.getBillOfLanding().getPortOfLoading().getPort());
            wordUtil.replacePOI(doc, "PORT_OF_DISCHARGE", q.getBillOfLanding().getPortOfDischarge().getPort());
        });
        InspectionReportDTO inspectionWeightReport = foreignInvoice.getInspectionWeightReport();
        InspectionReportDTO inspectionAssayReport = foreignInvoice.getInspectionAssayReport();
        ForeignInvoiceItemDTO.Info foreignInvoiceItem = foreignInvoice.getForeignInvoiceItems().get(0);

        BigDecimal weightGW = inspectionWeightReport.getWeightGW().multiply(new BigDecimal(foreignInvoice.getPercent()));
        BigDecimal weightND = inspectionWeightReport.getWeightND().multiply(new BigDecimal(foreignInvoice.getPercent()));
        wordUtil.replacePOI(doc, "WEIGHT_GW", weightGW.toString());
        wordUtil.replacePOI(doc, "WEIGHT_ND", weightND.toString());
        wordUtil.replacePOI(doc, "MOISTURE_WEIGHT", String.valueOf(weightGW.subtract(weightND)));
        wordUtil.replacePOI(doc, "TOTAL_GROSS", weightGW.toString());

        List<Object> deliverTerms = deliveryTerms.get(EContractDetailValueKey.INCOTERM.getId());
        if (deliverTerms != null) {
            IncotermDTO.Info map = modelMapper.map(deliverTerms.get(0), IncotermDTO.Info.class);
            wordUtil.replacePOI(doc, "INCOTERM_TITLE_EN", map.getIncotermRules().get(0).getIncotermRule().getTitleEn());
            wordUtil.replacePOI(doc, "INCOTERM_VERSION", map.getIncotermVersion().getIncotermVersion().toString());
        }
        List<ForeignInvoiceItemDetailDTO.Info> foreignInvoiceItemDetails = foreignInvoiceItem.getForeignInvoiceItemDetails();
        ForeignInvoiceItemDetailDTO.Info cu_detial = foreignInvoiceItemDetails.stream().filter(q -> q.getMaterialElementId() == 1).findFirst().orElse(new ForeignInvoiceItemDetailDTO.Info());
        ForeignInvoiceItemDetailDTO.Info ag_detial = foreignInvoiceItemDetails.stream().filter(q -> q.getMaterialElementId() == 2).findFirst().orElse(new ForeignInvoiceItemDetailDTO.Info());
        ForeignInvoiceItemDetailDTO.Info au_detial = foreignInvoiceItemDetails.stream().filter(q -> q.getMaterialElementId() == 3).findFirst().orElse(new ForeignInvoiceItemDetailDTO.Info());

        BigDecimal cuDedRate = cu_detial.getDeductionUnitConversionRate();
        BigDecimal agDedRate = ag_detial.getDeductionUnitConversionRate();
        BigDecimal auDedRate = au_detial.getDeductionUnitConversionRate();

        wordUtil.replacePOI(doc, "CU_PRICE_RATE", (cuDedRate != null && !cuDedRate.equals(BigDecimal.valueOf(0)) && !cuDedRate.equals(BigDecimal.valueOf(1)) ? "x   " + cuDedRate.toString() : ""));
        wordUtil.replacePOI(doc, "AG_PRICE_RATE", (agDedRate != null && !agDedRate.equals(BigDecimal.valueOf(0)) && !agDedRate.equals(BigDecimal.valueOf(1)) ? "x   " + agDedRate.toString() : ""));
        wordUtil.replacePOI(doc, "AU_PRICE_RATE", (auDedRate != null && !auDedRate.equals(BigDecimal.valueOf(0)) && !auDedRate.equals(BigDecimal.valueOf(1)) ? "x   " + auDedRate.toString() : ""));

        wordUtil.replacePOI(doc, "CU_PRICE_BASE", String.valueOf(cu_detial.getBasePrice()));
        wordUtil.replacePOI(doc, "AG_PRICE_BASE", String.valueOf(ag_detial.getBasePrice()));
        wordUtil.replacePOI(doc, "AU_PRICE_BASE", String.valueOf(au_detial.getBasePrice()));

        List<AssayInspectionTotalValuesDTO.Info> assayInspectionTotalValuesList = inspectionAssayReport.getAssayInspectionTotalValuesList();
        AssayInspectionTotalValuesDTO.Info cu_assay = assayInspectionTotalValuesList.stream().filter(q -> q.getMaterialElementId() == 1).findFirst().orElse(new AssayInspectionTotalValuesDTO.Info());
        AssayInspectionTotalValuesDTO.Info ag_assay = assayInspectionTotalValuesList.stream().filter(q -> q.getMaterialElementId() == 2).findFirst().orElse(new AssayInspectionTotalValuesDTO.Info());
        AssayInspectionTotalValuesDTO.Info au_assay = assayInspectionTotalValuesList.stream().filter(q -> q.getMaterialElementId() == 3).findFirst().orElse(new AssayInspectionTotalValuesDTO.Info());

        BigDecimal f_cu_assay = cu_assay.getValue().subtract(cu_detial.getDeductionValue());
        BigDecimal f_ag_assay = ag_assay.getValue().subtract(ag_detial.getDeductionValue());
        BigDecimal f_au_assay = au_assay.getValue().subtract(au_detial.getDeductionValue());

        wordUtil.replacePOI(doc, "CU_F_ASSAY", f_cu_assay.toString());
        wordUtil.replacePOI(doc, "AG_F_ASSAY", f_ag_assay.toString());
        wordUtil.replacePOI(doc, "AU_F_ASSAY", f_au_assay.toString());

        wordUtil.replacePOI(doc, "CU_ASSAY", String.valueOf(cu_assay.getValue()));
        wordUtil.replacePOI(doc, "AG_ASSAY", String.valueOf(au_assay.getValue()));
        wordUtil.replacePOI(doc, "AU_ASSAY", String.valueOf(ag_assay.getValue()));


        wordUtil.replacePOI(doc, "DED_CU_TYPE", cu_detial.getDeductionType().toString());
        wordUtil.replacePOI(doc, "DED_AG_TYPE", ag_detial.getDeductionType().toString());
        wordUtil.replacePOI(doc, "DED_AU_TYPE", au_detial.getDeductionType().toString());

        wordUtil.replacePOI(doc, "DED_CU_VALUE", cu_detial.getDeductionValue().toString());
        wordUtil.replacePOI(doc, "DED_AG_VALUE", ag_detial.getDeductionValue().toString());
        wordUtil.replacePOI(doc, "DED_AU_VALUE", au_detial.getDeductionValue().toString());


        wordUtil.replacePOI(doc, "CU_CALCULATION", f_cu_assay.multiply(cu_detial.getBasePrice().multiply(cuDedRate)).toString());
        wordUtil.replacePOI(doc, "AG_CALCULATION", f_ag_assay.multiply(ag_detial.getBasePrice().multiply(agDedRate)).toString());
        wordUtil.replacePOI(doc, "AU_CALCULATION", f_au_assay.multiply(au_detial.getBasePrice().multiply(auDedRate)).toString());

        wordUtil.replacePOI(doc, "UNIT_PRICE", foreignInvoice.getUnitPrice().toString());
        wordUtil.replacePOI(doc, "UNIT_COST", foreignInvoice.getUnitCost().toString());
        wordUtil.replacePOI(doc, "PURE", foreignInvoice.getUnitPrice().subtract(foreignInvoice.getUnitCost()).toString());

        wordUtil.replacePOI(doc, "RCTIC", foreignInvoiceItem.getTreatCost().toString());
        wordUtil.replacePOI(doc, "RCCU", cu_detial.getRcPrice().toString());
        wordUtil.replacePOI(doc, "RCAG", ag_detial.getRcPrice().toString());
        wordUtil.replacePOI(doc, "RCAU", au_detial.getRcPrice().toString());

        BigDecimal cuRcUnitRate = cu_detial.getRcUnitConversionRate();
        BigDecimal agRcUnitRate = ag_detial.getRcUnitConversionRate();
        BigDecimal auRcUnitRate = au_detial.getRcUnitConversionRate();

        wordUtil.replacePOI(doc, "CU_RC_RATE", (cuRcUnitRate != null && !cuRcUnitRate.equals(BigDecimal.valueOf(0)) && !cuRcUnitRate.equals(BigDecimal.valueOf(1)) ? "x   " + cuRcUnitRate.toString() : ""));
        wordUtil.replacePOI(doc, "AG_RC_RATE", (agRcUnitRate != null && !agRcUnitRate.equals(BigDecimal.valueOf(0)) && !agRcUnitRate.equals(BigDecimal.valueOf(1)) ? "x   " + agRcUnitRate.toString() : ""));
        wordUtil.replacePOI(doc, "AU_RC_RATE", (auRcUnitRate != null && !auRcUnitRate.equals(BigDecimal.valueOf(0)) && !auRcUnitRate.equals(BigDecimal.valueOf(1)) ? "x   " + auRcUnitRate.toString() : ""));

        wordUtil.replacePOI(doc, "CU_RC_PRICE", cu_detial.getRcBasePrice().toString());
        wordUtil.replacePOI(doc, "AG_RC_PRICE", ag_detial.getRcBasePrice().toString());
        wordUtil.replacePOI(doc, "AU_RC_PRICE", au_detial.getRcBasePrice().toString());

        wordUtil.replacePOI(doc, "SUM_FI_PRICE", foreignInvoice.getSumFIPrice().toString());
        wordUtil.replacePOI(doc, "CON_SUM_PRICE", foreignInvoice.getConversionSumPrice().toString());
        CurrencyRateDTO.Info conversionRef = foreignInvoice.getConversionRef();

        if (conversionRef != null) {

            wordUtil.replacePOI(doc, "CON_REFRENCE", conversionRef.getReference().toString());
            wordUtil.replacePOI(doc, "CON_DATE ", dtf.format(foreignInvoice.getConversionDate()));
        }

        wordUtil.replacePOI(doc, "CON_VALUE", foreignInvoice.getConversionRate().toString());
        wordUtil.replacePOI(doc, "CON_SUM_PRICE_TEXT", foreignInvoice.getConversionSumPriceText());
        wordUtil.replacePOI(doc, "MARKETING_MANAGER", foreignInvoice.getCreator().getFullName());

        response.setHeader("Content-Disposition", "attachment; filename=FI_CONCENTRATE");
        response.setContentType("application/vnd.ms-word");
        ServletOutputStream out = response.getOutputStream();
        doc.write(out);
        out.flush();
    }
}

