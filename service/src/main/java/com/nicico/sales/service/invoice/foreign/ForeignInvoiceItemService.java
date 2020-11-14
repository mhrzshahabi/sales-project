package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.*;
import com.nicico.sales.dto.contract.ContractDiscountDTO;
import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.iservice.IUnitService;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceItemService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceItemService extends GenericService<ForeignInvoiceItem, Long, ForeignInvoiceItemDTO.Create, ForeignInvoiceItemDTO.Info, ForeignInvoiceItemDTO.Update, ForeignInvoiceItemDTO.Delete> implements IForeignInvoiceItemService {

    private static final String INVENTORY = "inventory";
    private static final String PERCENT = "percent";
    private static final String ASSAY_INSPECTIONS = "assayInspections";
    private static final String WEIGHT_INSPECTION = "weightingInspection";
    private static final String LOT_NO = "lotNo";
    private static final String PRICE = "price";
    private static final String AMOUNT = "amount";
    private static final String DISCOUNT = "discount";
    private static final String WEIGHT_ND = "weightND";
    private static final String WEIGHT_GW = "weightGW";
    private static final String WEIGHT_DIFF = "weightDiff";
    private static final String UNIT_CONVERSION_RATE = "unitConversionRate";
    private final IUnitService unitService;
    private final IPriceBaseService priceBaseService;
    private final IInspectionReportService inspectionReportService;

    @Override
    @Transactional
    @Action(value = ActionType.List)
    public ForeignInvoiceItemDTO.Calc2Data getCalculation2Data(Long contractId, Date sendDate, Long financeUnitId, Long inspectionAssayDataId, Long inspectionWeightDataId, ContractDetailDataDTO.Info contractDetailDataInfo) {

        InspectionReportDTO.Info inspectionAssayReportDTO = inspectionReportService.get(inspectionAssayDataId);
        List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues = inspectionAssayReportDTO.getAssayInspections();

        InspectionReportDTO.Info inspectionWeightReportDTO = inspectionReportService.get(inspectionWeightDataId);
        List<WeightInspectionDTO.InfoWithoutInspectionReport> weightValues = inspectionWeightReportDTO.getWeightInspections();

        Set<Long> materialIds = assayValues.stream().filter(q -> q.getMaterialElement().getPayable() || q.getMaterialElement().getPenalty()).map(q -> q.getMaterialElement().getMaterialId()).collect(Collectors.toSet());
        List<Long> inventoryIds = weightValues.stream().map(WeightInspectionDTO::getInventoryId).collect(Collectors.toList());
        if (materialIds.size() != 1)
            throw new SalesException2(ErrorType.BadRequest, "material", "There is multiple material.");

        String priceContent = contractDetailDataInfo.getPriceContent();
        String quotationalPeriodContent = contractDetailDataInfo.getQuotationalPeriodContent();
        List<ContractDiscountDTO.Info> discountArticle = contractDetailDataInfo.getDiscount();

        List<PriceBaseDTO.Info> basePrices = priceBaseService.getAverageOfBasePricesByMOAS(contractId, financeUnitId, contractDetailDataInfo.getMOAS());

        List<Map<String, Object>> data = new ArrayList<>();
        List<ForeignInvoiceItemDTO.FieldData> fields = createFields(assayValues);
        createData(inventoryIds, assayValues, weightValues, discountArticle, basePrices, financeUnitId);

        ForeignInvoiceItemDTO.Calc2Data result = new ForeignInvoiceItemDTO.Calc2Data();
        result.setData(data);
        result.setFields(fields);
        result.setPriceBase(basePrices);
        result.setPriceContent(priceContent);
        result.setQuotationalPeriodContent(quotationalPeriodContent);

        return result;
    }

    @Override
    public ForeignInvoiceItemDTO.Calc2Data getCalculationMolybdenumData(Long contractId, Date sendDate, Long financeUnitId, Long inspectionAssayDataId, Long inspectionWeightDataId, ContractDetailDataDTO.Info contractDetailDataInfo) {

        InspectionReportDTO.Info inspectionAssayReportDTO = inspectionReportService.get(inspectionAssayDataId);
        List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues = inspectionAssayReportDTO.getAssayInspections();

        InspectionReportDTO.Info inspectionWeightReportDTO = inspectionReportService.get(inspectionWeightDataId);
        List<WeightInspectionDTO.InfoWithoutInspectionReport> weightValues = inspectionWeightReportDTO.getWeightInspections();
        List<Long> inventoryIds = weightValues.stream().map(WeightInspectionDTO::getInventoryId).collect(Collectors.toList());

        String priceContent = contractDetailDataInfo.getPriceContent();
        String quotationalPeriodContent = contractDetailDataInfo.getQuotationalPeriodContent();
        List<ContractDiscountDTO.Info> discountArticle = contractDetailDataInfo.getDiscount();

        List<PriceBaseDTO.Info> basePrices = priceBaseService.getAverageOfBasePricesByMOAS(contractId, financeUnitId, contractDetailDataInfo.getMOAS());

        ForeignInvoiceItemDTO.Calc2Data result = new ForeignInvoiceItemDTO.Calc2Data();
        List<ForeignInvoiceItemDTO.FieldData> fields = createFields(assayValues);
        List<Map<String, Object>> data = createData(inventoryIds, assayValues, weightValues, discountArticle, basePrices, financeUnitId);

        result.setData(data);
        result.setFields(fields);
        result.setPriceBase(basePrices);
        result.setPriceContent(priceContent);
        result.setQuotationalPeriodContent(quotationalPeriodContent);

        return result;
    }

    // Mine
    private List<ForeignInvoiceItemDTO.FieldData> createFields(List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues) {

        List<ForeignInvoiceItemDTO.FieldData> fields = new ArrayList<>();

        Set<MaterialElementDTO.Info> materialElements = assayValues.stream().map(AssayInspectionDTO.InfoWithoutInspectionReport::getMaterialElement).collect(Collectors.toSet());
        Set<Long> materialElementIds = materialElements.stream().map(MaterialElementDTO.Info::getId).collect(Collectors.toSet());
        materialElementIds.forEach(materialElementId -> {

            MaterialElementDTO.Info materialElement = materialElements.stream().filter(q -> q.getId().longValue() == materialElementId).findFirst().orElseThrow(() -> new NotFoundException(MaterialElement.class));
            ElementDTO.Info element = materialElement.getElement();
            if (!materialElement.getPayable() && !materialElement.getPenalty()) return;

            fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName(), "float", element.getName(), "0.###", "false", "false"));
            if (materialElement.getPayable())
                fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName() + "Content", "float", element.getName() + " Content", "0.###", "false", "false"));
            if (materialElement.getPenalty())
                fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName() + "Discount", "float", element.getName() + " Discount", "0.###", "false", "false"));
        });

        return fields;
    }

//    private List<ForeignInvoiceItemDTO.FieldData> createFields(List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues) {
//
//        List<ForeignInvoiceItemDTO.FieldData> fields = new ArrayList<>();
//
//        fields.add(new ForeignInvoiceItemDTO.FieldData(LOT_NO, "text", "Label"));
//        fields.add(new ForeignInvoiceItemDTO.FieldData(WEIGHT_ND, "float", "Net Weight", "0.###", "false", "false"));
//        fields.add(new ForeignInvoiceItemDTO.FieldData(WEIGHT_GW, "float", "Gross Weight", "0.###", "false", "false"));
//
//        Set<MaterialElementDTO.Info> materialElements = assayValues.stream().map(AssayInspectionDTO.InfoWithoutInspectionReport::getMaterialElement).collect(Collectors.toSet());
//        Set<Long> materialElementIds = materialElements.stream().map(MaterialElementDTO.Info::getId).collect(Collectors.toSet());
//        materialElementIds.forEach(materialElementId -> {
//
//            MaterialElementDTO.Info materialElement = materialElements.stream().filter(q -> q.getId().longValue() == materialElementId).findFirst().orElseThrow(() -> new NotFoundException(MaterialElement.class));
//            ElementDTO.Info element = materialElement.getElement();
//            if (!materialElement.getPayable() && !materialElement.getPenalty()) return;
//
//            fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName(), "float", element.getName(), "0.###", "false", "false"));
//            if (materialElement.getPayable())
//                fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName() + "Content", "float", element.getName() + " Content", "0.###", "false", "false"));
//            if (materialElement.getPenalty())
//                fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName() + "Discount", "float", element.getName() + " Discount", "0.###", "false", "false"));
//        });
//
//        fields.add(new ForeignInvoiceItemDTO.FieldData(PRICE, "float", "Price", "0.##", "false", "false"));
//        fields.add(new ForeignInvoiceItemDTO.FieldData(DISCOUNT, "float", "Discount", "0.##", "false", "false"));
//        fields.add(new ForeignInvoiceItemDTO.FieldData(UNIT_CONVERSION_RATE, "float", "Conversion Rate", "0.###", "true", "true"));
//        fields.add(new ForeignInvoiceItemDTO.FieldData(AMOUNT, "float", "Value Amount", "0.##", "false", "false"));
//
//        return fields;
//    }

    // Mine
    private List<Map<String, Object>> createData(List<Long> inventoryIds, List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues, List<WeightInspectionDTO.InfoWithoutInspectionReport> weightValues, List<ContractDiscountDTO.Info> discountArticle, List<PriceBaseDTO.Info> basePrices, Long financeUnitId) {

        List<Map<String, Object>> data = new ArrayList<>();
        inventoryIds.forEach(inventoryId -> {

            HashMap<String, Object> record = new HashMap<>();

            List<AssayInspectionDTO.InfoWithoutInspectionReport> assays = assayValues.stream().filter(q -> q.getInventoryId().longValue() == inventoryId.longValue()).collect(Collectors.toList());
            if (assays.size() == 0) throw new NotFoundException(AssayInspection.class);

            InventoryDTO.Info inventory = assays.get(0).getInventory();
            record.put(INVENTORY, inventory);
            record.put(LOT_NO, inventory.getLabel());

            List<WeightInspectionDTO.InfoWithoutInspectionReport> weights = weightValues.stream().filter(q -> q.getInventoryId().longValue() == inventoryId.longValue()).collect(Collectors.toList());
            WeightInspectionDTO.InfoWithoutInspectionReport weight = weights.stream().filter(w -> w.getInventoryId().longValue() == inventoryId).findFirst().orElseThrow(() -> new NotFoundException(WeightInspection.class));
            record.put(PERCENT, 100);
            record.put(WEIGHT_GW, weight.getWeightGW());
            record.put(WEIGHT_ND, weight.getWeightND());

            final BigDecimal[] price = {new BigDecimal(0)};
            final BigDecimal[] discount = {new BigDecimal(0)};
            assays.stream().filter(a -> a.getInventoryId().longValue() == inventoryId).forEach(a -> {

                ElementDTO.Info element = a.getMaterialElement().getElement();
                if (!a.getMaterialElement().getPayable() && !a.getMaterialElement().getPenalty()) return;

                record.put(element.getName(), a.getValue());
                Optional<ContractDiscountDTO.Info> contractDiscount = discountArticle.stream().filter(q -> q.getMaterialElementId().longValue() == a.getMaterialElementId()).findFirst();
                PriceBaseDTO.Info priceBaseDTO = basePrices.stream().filter(q -> q.getElementId().longValue() == element.getId()).findFirst().orElseThrow(() -> new NotFoundException(PriceBase.class));
                if (a.getMaterialElement().getPenalty()) {

                    if (contractDiscount.isPresent() && a.getValue().compareTo(BigDecimal.valueOf(contractDiscount.get().getLowerBound())) > 0 && a.getValue().compareTo(BigDecimal.valueOf(contractDiscount.get().getUpperBound())) <= 0) {

                        discount[0] = discount[0].add(BigDecimal.valueOf(contractDiscount.get().getDiscount()));
                        record.put(element.getName() + "Discount", contractDiscount.get().getDiscount());
                    } else record.put(element.getName() + "Discount", new BigDecimal(0));
                }
                if (a.getMaterialElement().getPayable()) {

                    BigDecimal content = weight.getWeightND().multiply(a.getValue()).divide(new BigDecimal(100), MathContext.DECIMAL32);
                    record.put(element.getName() + "Content", content);
                }
            });

            record.put(PRICE, new BigDecimal(0));
            record.put(DISCOUNT, discount[0]);
            record.put(UNIT_CONVERSION_RATE, 1);
            record.put(AMOUNT, new BigDecimal(0));

            data.add(record);
        });

        return data;
    }

//    private void createData(List<Long> inventoryIds, List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues, List<WeightInspectionDTO.InfoWithoutInspectionReport> weightValues, List<ContractDiscount> discountArticle, List<PriceBaseDTO.Info> basePrices, List<Map<String, Object>> data, Long financeUnitId) {
//
//        inventoryIds.forEach(inventoryId -> {
//
//            HashMap<String, Object> record = new HashMap<>();
//
//            List<AssayInspectionDTO.InfoWithoutInspectionReport> assays = assayValues.stream().filter(q -> q.getInventoryId().longValue() == inventoryId.longValue()).collect(Collectors.toList());
//            if (assays.size() == 0) throw new NotFoundException(AssayInspection.class);
//
//            InventoryDTO.Info inventory = assays.get(0).getInventory();
//            record.put(INVENTORY, inventory);
//            record.put(LOT_NO, inventory.getLabel());
//            record.put(ASSAY_INSPECTIONS, assays);
//
//            List<WeightInspectionDTO.InfoWithoutInspectionReport> weights = weightValues.stream().filter(q -> q.getInventoryId().longValue() == inventoryId.longValue()).collect(Collectors.toList());
//            WeightInspectionDTO.InfoWithoutInspectionReport weight = weights.stream().filter(w -> w.getInventoryId().longValue() == inventoryId).findFirst().orElseThrow(() -> new NotFoundException(WeightInspection.class));
//            record.put(WEIGHT_INSPECTION, weight);
//            record.put(WEIGHT_GW, weight.getWeightGW());
//            record.put(WEIGHT_GW + "_UNIT", weight.getUnit().getSymbolUnit().name());
//            record.put(WEIGHT_ND, weight.getWeightND());
//            record.put(WEIGHT_ND + "_UNIT", weight.getUnit().getSymbolUnit().name());
//            record.put(WEIGHT_DIFF, weight.getWeightDiff());
//            record.put(WEIGHT_DIFF + "_UNIT", weight.getUnit().getSymbolUnit().name());
//
//            final BigDecimal[] price = {new BigDecimal(0)};
//            final BigDecimal[] discount = {new BigDecimal(0)};
//            assays.stream().filter(a -> a.getInventoryId().longValue() == inventoryId).forEach(a -> {
//
//                ElementDTO.Info element = a.getMaterialElement().getElement();
//                if (!a.getMaterialElement().getPayable() && !a.getMaterialElement().getPenalty()) return;
//
//                record.put(element.getName(), a.getValue());
//                record.put(element.getName() + "_UNIT", a.getMaterialElement().getUnit().getSymbolUnit().name());
//                Optional<ContractDiscount> contractDiscount = discountArticle.stream().filter(q -> q.getMaterialElementId().longValue() == a.getMaterialElementId()).findFirst();
//                PriceBaseDTO.Info priceBaseDTO = basePrices.stream().filter(q -> q.getElementId().longValue() == element.getId()).findFirst().orElseThrow(() -> new NotFoundException(PriceBase.class));
//                if (a.getMaterialElement().getPenalty()) {
//
//                    if (contractDiscount.isPresent() && a.getValue().compareTo(contractDiscount.get().getLowerBound()) > 0 && a.getValue().compareTo(contractDiscount.get().getUpperBound()) <= 0) {
//
//                        discount[0] = discount[0].add(contractDiscount.get().getDiscount());
//                        record.put(element.getName() + "Discount", contractDiscount.get().getDiscount());
//                    } else record.put(element.getName() + "Discount", new BigDecimal(0));
//                    record.put(element.getName() + "Discount_UNIT", "PERCENT");
//                }
//                if (a.getMaterialElement().getPayable()) {
//
//                    BigDecimal content = weight.getWeightND().multiply(a.getValue()).divide(new BigDecimal(100), MathContext.DECIMAL32);
//                    record.put(element.getName() + "Content", content);
//                    record.put(element.getName() + "Content_UNIT", weight.getUnit().getSymbolUnit().name());
//                    price[0] = price[0].add(priceBaseDTO.getPrice().multiply(content));
//                }
//            });
//
//            UnitDTO.Info unit = unitService.get(financeUnitId);
//            record.put(PRICE, price[0]);
//            record.put(PRICE + "_UNIT", unit.getSymbolUnit().name());
//            record.put(DISCOUNT, discount[0]);
//            record.put(DISCOUNT + "_UNIT", "PERCENT");
//            record.put(UNIT_CONVERSION_RATE, 1);
//            record.put(AMOUNT, price[0].subtract(price[0].multiply(discount[0]).divide(new BigDecimal(100), MathContext.DECIMAL32)));
//            record.put(AMOUNT + "_UNIT", unit.getSymbolUnit().name());
//
//            data.add(record);
//        });
//    }

}
