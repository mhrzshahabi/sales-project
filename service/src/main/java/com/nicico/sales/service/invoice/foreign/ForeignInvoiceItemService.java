package com.nicico.sales.service.invoice.foreign;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.*;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IAssayInspectionService;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.iservice.contract.IContractDetailService2;
import com.nicico.sales.iservice.contract.IContractService2;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceItemService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.entities.contract.ContractDiscount;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceItemService extends GenericService<ForeignInvoiceItem, Long, ForeignInvoiceItemDTO.Create, ForeignInvoiceItemDTO.Info, ForeignInvoiceItemDTO.Update, ForeignInvoiceItemDTO.Delete> implements IForeignInvoiceItemService {

    private final IPriceBaseService priceBaseService;
    private final IContractService2 contractService2;
    private final IContractDetailService2 contractDetailService2;
    private final IAssayInspectionService assayInspectionService;
    private final IWeightInspectionService weightInspectionService;

    private static final String LOT_NO = "lotNo";
    private static final String PRICE = "price";
    private static final String AMOUNT = "amount";
    private static final String DISCOUNT = "discount";
    private static final String WEIGHT_ND = "weightND";
    private static final String WEIGHT_GW = "weightGW";
    private static final String WEIGHT_DIFF = "weightDiff";
    private static final String SUM_PRICE = "sumPrice";
    private static final String UNIT_CONVERSION_RATE = "unitConversionRate";

    @Override
    @Transactional
    @Action(value = ActionType.List)
    public ForeignInvoiceItemDTO.Calc2Data getCalculation2Data(Long contractId, Long shipmentId, InspectionReportMilestone reportMilestone, List<Long> inventoryIds, PriceBaseReference reference, Integer year, Integer month, Long financeUnitId) {

        List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues = assayInspectionService.getAssayValues(shipmentId, reportMilestone, inventoryIds);
        Set<Long> materialIds = assayValues.stream().map(q -> q.getMaterialElement().getMaterialId()).collect(Collectors.toSet());
        if (materialIds.size() != 1)
            throw new SalesException2(ErrorType.Forbidden, "material", "There is multiple material.");

        List<WeightInspectionDTO.InfoWithoutInspectionReport> weightValues = weightInspectionService.getWeightValues(shipmentId, reportMilestone, inventoryIds);
        // ContractDetailDTO2.Info priceDetail = contractDetailService2.getContractDetailByContractDetailTypeCode(contractId, EContractDetailTypeCode);
        String priceArticleText = ""; // priceDetail.content;
        List<ContractDiscount> discountArticle = new ArrayList<>(); // contractService2.getOperationalDataOfContractArticle(contractId, EContractDetailTypeCode., EContractDetailValueKey.);

        List<PriceBaseDTO.Info> basePrices = priceBaseService.getAverageOfElementBasePrices(reference, year, month, materialIds.iterator().next(), financeUnitId);

        List<Map<String, Object>> data = new ArrayList<>();
        List<ForeignInvoiceItemDTO.FieldData> fields = createFields(assayValues, discountArticle);
        createData(inventoryIds, assayValues, weightValues, discountArticle, basePrices, data);

        ForeignInvoiceItemDTO.Calc2Data result = new ForeignInvoiceItemDTO.Calc2Data();
        result.setData(data);
        result.setFields(fields);
        result.setPriceBase(basePrices);
        result.setPriceArticleText(priceArticleText);

        return result;
    }

    private List<ForeignInvoiceItemDTO.FieldData> createFields(List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues, List<ContractDiscount> discountArticle) {

        List<ForeignInvoiceItemDTO.FieldData> fields = new ArrayList<>();

        fields.add(new ForeignInvoiceItemDTO.FieldData(LOT_NO, "text", "Label"));
        fields.add(new ForeignInvoiceItemDTO.FieldData(WEIGHT_ND, "float", "Net Weight", "0.###", "false"));
        fields.add(new ForeignInvoiceItemDTO.FieldData(WEIGHT_GW, "float", "Gross Weight", "0.###", "false"));

        Set<MaterialElementDTO.Info> materialElements = assayValues.stream().map(AssayInspectionDTO.InfoWithoutInspectionReport::getMaterialElement).collect(Collectors.toSet());
        materialElements.forEach(materialElement -> {

            ElementDTO.Info element = materialElement.getElement();
            if (!element.getPayable())
                return;

            fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName(), "float", element.getName(), "0.###", "false"));
            Optional<ContractDiscount> contractDiscount = discountArticle.stream().filter(q -> q.getMaterialElementId().longValue() == materialElement.getId()).findFirst();
            if (!contractDiscount.isPresent())
                fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName() + "Content", "float", element.getName() + " Content", "0.###", "false"));
            else
                fields.add(new ForeignInvoiceItemDTO.FieldData(element.getName() + "Discount", "float", element.getName() + " Discount", "0.###", "false"));
        });

        fields.add(new ForeignInvoiceItemDTO.FieldData(PRICE, "float", "Price", "0.##", "false"));
        fields.add(new ForeignInvoiceItemDTO.FieldData(DISCOUNT, "float", "Discount", "0.##", "false"));
        fields.add(new ForeignInvoiceItemDTO.FieldData(UNIT_CONVERSION_RATE, "float", "Conversion Rate", "0.###", "true"));
        fields.add(new ForeignInvoiceItemDTO.FieldData(AMOUNT, "float", "Value Amount", "0.##", "false"));

        return fields;
    }

    private void createData(List<Long> inventoryIds, List<AssayInspectionDTO.InfoWithoutInspectionReport> assayValues, List<WeightInspectionDTO.InfoWithoutInspectionReport> weightValues, List<ContractDiscount> discountArticle, List<PriceBaseDTO.Info> basePrices, List<Map<String, Object>> data) {

        inventoryIds.forEach(inventoryId -> {

            HashMap<String, Object> record = new HashMap<>();

            List<AssayInspectionDTO.InfoWithoutInspectionReport> assays = assayValues.stream().filter(q -> q.getInventoryId().longValue() == inventoryId.longValue()).collect(Collectors.toList());
            InventoryDTO.Info inventory = assays.get(0).getInventory();
            record.put(LOT_NO, inventory.getLabel());

            List<WeightInspectionDTO.InfoWithoutInspectionReport> weights = weightValues.stream().filter(q -> q.getInventoryId().longValue() == inventoryId.longValue()).collect(Collectors.toList());
            WeightInspectionDTO.InfoWithoutInspectionReport weight = weights.stream().filter(w -> w.getInventoryId().longValue() == inventoryId).findFirst().orElseThrow(() -> new NotFoundException(WeightInspection.class));
            record.put(WEIGHT_GW, weight.getWeightGW());
            record.put(WEIGHT_ND, weight.getWeightND());
            record.put(WEIGHT_DIFF, weight.getWeightDiff());

            final BigDecimal[] price = {new BigDecimal(0)};
            final BigDecimal[] discount = {new BigDecimal(0)};
            assays.stream().filter(a -> a.getInventoryId().longValue() == inventoryId).forEach(a -> {

                ElementDTO.Info element = a.getMaterialElement().getElement();
                if (!element.getPayable())
                    return;

                record.put(element.getName(), a.getValue());
                Optional<ContractDiscount> contractDiscount = discountArticle.stream().filter(q -> q.getMaterialElementId().longValue() == a.getMaterialElementId()).findFirst();
                PriceBaseDTO.Info priceBaseDTO = basePrices.stream().filter(q -> q.getElementId().longValue() == element.getId()).findFirst().orElseThrow(() -> new NotFoundException(PriceBase.class));
                if (contractDiscount.isPresent()) {

                    if (a.getValue().compareTo(contractDiscount.get().getLowerBound()) > 0 &&
                            a.getValue().compareTo(contractDiscount.get().getUpperBound()) <= 0) {

                        discount[0] = discount[0].add(contractDiscount.get().getDiscount());
                        record.put(element.getName() + "Discount", contractDiscount.get().getDiscount());
                    }
                } else {
                    BigDecimal content = weight.getWeightND().multiply(a.getValue());
                    record.put(element.getName() + "Content", content);
                    price[0] = price[0].add(priceBaseDTO.getPrice().multiply(content));
                }
            });

            record.put(PRICE, price);
            record.put(DISCOUNT, discount);
            record.put(UNIT_CONVERSION_RATE, 1);
            record.put(AMOUNT, price[0].subtract(price[0].multiply(discount[0]).divide(new BigDecimal(100), RoundingMode.HALF_DOWN)));

            data.add(record);
        });
    }
}
