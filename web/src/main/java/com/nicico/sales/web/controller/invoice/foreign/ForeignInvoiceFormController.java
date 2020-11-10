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
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItemDetail;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoicePayment;
import com.nicico.sales.model.enumeration.*;
import com.nicico.sales.service.ContractDetailValueService2;
import com.nicico.sales.utility.SecurityChecker;
import com.nicico.sales.web.controller.utility.WordUtil;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/foreign-invoice")
public class ForeignInvoiceFormController {

    private final WordUtil wordUtil;
    private final ObjectMapper objectMapper;
    private final IForeignInvoiceService foreignInvoiceService;
    private final ContractDetailValueService2 contractDetailValueService2;
    @Autowired
    protected ModelMapper modelMapper;

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
        Map<String, List<Object>> deliveryTerms = contractDetailValueService2.get(foreignInvoice.getShipment().getContractShipment().getContractId(), EContractDetailTypeCode.DeliveryTerms, EContractDetailValueKey.INCOTERM, true);
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
        List<ForeignInvoiceBillOfLandingDTO.InfoWithoutForeignInvoice> billOfLanding = foreignInvoice.getBillLadings();
        billOfLanding.forEach(q -> {
            wordUtil.replacePOI(doc, "SWITCH_DOC_NO", q.getBillOfLanding().getSwitchDocumentNo());
            wordUtil.replacePOI(doc, "NICICO_DOC_NO", q.getBillOfLanding().getDocumentNo());
            wordUtil.replacePOI(doc, "PORT_OF_LOADING", q.getBillOfLanding().getPortOfLoading().getPort());
            wordUtil.replacePOI(doc, "PORT_OF_DISCHARGE", q.getBillOfLanding().getPortOfDischarge().getPort());
        });
        InspectionReportDTO.Info inspectionWeightReport = foreignInvoice.getInspectionWeightReport();
        InspectionReportDTO.Info inspectionAssayReport = foreignInvoice.getInspectionAssayReport();
        ForeignInvoiceItemDTO.InfoWithoutForeignInvoice foreignInvoiceItem = foreignInvoice.getForeignInvoiceItems().get(0);

        BigDecimal weightGW = inspectionWeightReport.getWeightGW().multiply(new BigDecimal(foreignInvoice.getPercent()));
        BigDecimal weightND = inspectionWeightReport.getWeightND().multiply(new BigDecimal(foreignInvoice.getPercent()));
        wordUtil.replacePOI(doc, "WEIGHT_GW", weightGW.toString());
        wordUtil.replacePOI(doc, "WEIGHT_ND", weightND.toString());
        wordUtil.replacePOI(doc, "MOISTURE_WEIGHT", String.valueOf(weightGW.subtract(weightND)));
        wordUtil.replacePOI(doc, "TOTAL_GROSS", weightGW.toString());

        IncotermDTO.Info map = modelMapper.map(deliveryTerms.get(EContractDetailValueKey.INCOTERM.getId()).get(0), IncotermDTO.Info.class);
        wordUtil.replacePOI(doc, "INCOTERM_TITLE_EN", map.getIncotermRules().get(0).getIncotermRule().getTitleEn());
        wordUtil.replacePOI(doc, "INCOTERM_VERSION", map.getIncotermVersion().getIncotermVersion().toString());

        List<ForeignInvoiceItemDetailDTO.InfoWithoutForeignInvoiceItem> foreignInvoiceItemDetails = foreignInvoiceItem.getForeignInvoiceItemDetails();
        ForeignInvoiceItemDetailDTO.InfoWithoutForeignInvoiceItem cu_detial = foreignInvoiceItemDetails.stream().filter(q -> q.getMaterialElementId() == 1).findFirst().orElse(new ForeignInvoiceItemDetailDTO.InfoWithoutForeignInvoiceItem());
        ForeignInvoiceItemDetailDTO.InfoWithoutForeignInvoiceItem au_detial = foreignInvoiceItemDetails.stream().filter(q -> q.getMaterialElementId() == 3).findFirst().orElse(new ForeignInvoiceItemDetailDTO.InfoWithoutForeignInvoiceItem());
        ForeignInvoiceItemDetailDTO.InfoWithoutForeignInvoiceItem ag_detial = foreignInvoiceItemDetails.stream().filter(q -> q.getMaterialElementId() == 2).findFirst().orElse(new ForeignInvoiceItemDetailDTO.InfoWithoutForeignInvoiceItem());

        wordUtil.replacePOI(doc, "PRICE_CU_BASE", String.valueOf(cu_detial.getBasePrice()));
        wordUtil.replacePOI(doc, "PRICE_AG_BASE", String.valueOf(ag_detial.getBasePrice()));
        wordUtil.replacePOI(doc, "PRICE_AU_BASE", String.valueOf(au_detial.getBasePrice()));

        List<AssayInspectionTotalValuesDTO.Info> assayInspectionTotalValuesList = inspectionAssayReport.getAssayInspectionTotalValuesList();
        AssayInspectionTotalValuesDTO.Info cu_assay = assayInspectionTotalValuesList.stream().filter(q -> q.getMaterialElementId() == 1).findFirst().orElse(new AssayInspectionTotalValuesDTO.Info());
        AssayInspectionTotalValuesDTO.Info au_assay = assayInspectionTotalValuesList.stream().filter(q -> q.getMaterialElementId() == 3).findFirst().orElse(new AssayInspectionTotalValuesDTO.Info());
        AssayInspectionTotalValuesDTO.Info ag_assay = assayInspectionTotalValuesList.stream().filter(q -> q.getMaterialElementId() == 2).findFirst().orElse(new AssayInspectionTotalValuesDTO.Info());

        BigDecimal f_cu_assay = cu_assay.getValue().subtract(cu_detial.getDeductionValue());
        BigDecimal f_ag_assay = ag_assay.getValue().subtract(ag_detial.getDeductionValue());
        BigDecimal f_au_assay = au_assay.getValue().subtract(au_detial.getDeductionValue());

        wordUtil.replacePOI(doc, "CU_F_ASSAY", f_cu_assay.toString());
        wordUtil.replacePOI(doc, "AG_F_ASSAY", f_ag_assay.toString());
        wordUtil.replacePOI(doc, "AU_F_ASSAY", f_au_assay.toString());

        wordUtil.replacePOI(doc, "CU_ASSAY", String.valueOf(cu_assay.getValue()));
        wordUtil.replacePOI(doc, "AG_ASSAY", String.valueOf(au_assay.getValue()));
        wordUtil.replacePOI(doc, "AU_ASSAY", String.valueOf(ag_assay.getValue()));


        wordUtil.replacePOI(doc, "CU_DEDUCTION_TYPE", cu_detial.getDeductionType().toString());
        wordUtil.replacePOI(doc, "AG_DEDUCTION_TYPE", ag_detial.getDeductionType().toString());
        wordUtil.replacePOI(doc, "AU_DEDUCTION_TYPE", au_detial.getDeductionType().toString());

        wordUtil.replacePOI(doc, "CU_DED_VALUE", cu_detial.getDeductionValue().toString());
        wordUtil.replacePOI(doc, "AG_DED_VALUE", ag_detial.getDeductionValue().toString());
        wordUtil.replacePOI(doc, "AU_DED_VALUE", au_detial.getDeductionValue().toString());


        wordUtil.replacePOI(doc, "CU_CALCULATION", f_cu_assay.multiply(cu_detial.getBasePrice()).toString());
        wordUtil.replacePOI(doc, "AG_CALCULATION", f_ag_assay.multiply(ag_detial.getBasePrice()).toString());
        wordUtil.replacePOI(doc, "AU_CALCULATION", f_au_assay.multiply(au_detial.getBasePrice()).toString());

        wordUtil.replacePOI(doc, "UNIT_PRICE", foreignInvoice.getUnitPrice().toString());
        wordUtil.replacePOI(doc, "UNIT_COST", foreignInvoice.getUnitCost().toString());
        wordUtil.replacePOI(doc, "PURE", foreignInvoice.getUnitPrice().subtract(foreignInvoice.getUnitCost()).toString());

        wordUtil.replacePOI(doc, "RC_TIC", foreignInvoiceItem.getTreatCost().toString());
        wordUtil.replacePOI(doc, "RC_CU", cu_detial.getRcPrice().toString());
        wordUtil.replacePOI(doc, "RC_AG", ag_detial.getRcPrice().toString());
        wordUtil.replacePOI(doc, "RC_AU", au_detial.getRcPrice().toString());

        wordUtil.replacePOI(doc, "CU_RC_BASE_PRICE", cu_detial.getRcBasePrice().toString());
        wordUtil.replacePOI(doc, "AG_RC_BASE_PRICE", ag_detial.getRcBasePrice().toString());
        wordUtil.replacePOI(doc, "AU_RC_BASE_PRICE", au_detial.getRcBasePrice().toString());

        wordUtil.replacePOI(doc, "SUM_FI_PRICE", foreignInvoice.getSumFIPrice().toString());
        wordUtil.replacePOI(doc, "CONVERSION_SUM_PRICE", foreignInvoice.getConversionSumPrice().toString());
        CurrencyRateDTO.Info conversionRef = foreignInvoice.getConversionRef();

        if (conversionRef != null) {

            wordUtil.replacePOI(doc, "CONVERSION_REFRENCE", conversionRef.getReference().toString());
            wordUtil.replacePOI(doc, "CONVERSION_DATE ", dtf.format(foreignInvoice.getConversionDate()));
        }

        wordUtil.replacePOI(doc, "CONVERSION_VALUE", foreignInvoice.getConversionRate().toString());
        wordUtil.replacePOI(doc, "CONVERSION_SUM_PRICE_TEXT", foreignInvoice.getConversionSumPriceText());
        wordUtil.replacePOI(doc, "MARKETING_MANAGER", foreignInvoice.getCreator().getFullName());

        response.setHeader("Content-Disposition", "attachment; filename=FI_CONCENTRATE");
        response.setContentType("application/vnd.ms-word");
        ServletOutputStream out = response.getOutputStream();
        doc.write(out);
        out.flush();
    }
}
