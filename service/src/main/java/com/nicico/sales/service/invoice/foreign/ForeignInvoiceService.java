package com.nicico.sales.service.invoice.foreign;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ghasemkiani.util.icu.PersianCalendar;
import com.ibm.icu.util.Calendar;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InvoiceTypeDTO;
import com.nicico.sales.dto.MaterialElementDTO;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.dto.contract.ContractDTO;
import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.dto.contract.ContractDiscountDTO;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.dto.invoice.foreign.*;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IContractDetailValueService2;
import com.nicico.sales.iservice.contract.IContractDetailService;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.entities.contract.ContractDiscount;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceBillOfLading;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.repository.UnitDAO;
import com.nicico.sales.repository.contract.ContractDAO;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceBillOfLadingDAO;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.service.InvoiceTypeService;
import com.nicico.sales.service.contract.ContractService;
import com.nicico.sales.utility.InvoiceNoGenerator;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceService extends GenericService<ForeignInvoice, Long, ForeignInvoiceDTO.Create, ForeignInvoiceDTO.Info, ForeignInvoiceDTO.Update, ForeignInvoiceDTO.Delete> implements IForeignInvoiceService {

    private final UnitDAO unitDAO;
    private final ContractDAO contractDAO;
    private final ObjectMapper objectMapper;
    private final ContractService contractService;
    private final InvoiceTypeService invoiceTypeService;
    private final InvoiceNoGenerator invoiceNoGenerator;
    private final MaterialElementDAO materialElementDAO;
    private final ResourceBundleMessageSource messageSource;
    private final IContractDetailService contractDetailService;
    private final ForeignInvoiceItemService foreignInvoiceItemService;
    private final IContractDetailValueService2 contractDetailValueService2;
    private final ForeignInvoicePaymentService foreignInvoicePaymentService;
    private final ForeignInvoiceBillOfLadingDAO foreignInvoiceBillOfLadingDAO;
    private final ForeignInvoiceItemDetailService foreignInvoiceItemDetailService;
    private final ForeignInvoiceBillOfLadingService foreignInvoiceBillOfLadingService;


    @Override
    @Transactional
    @Action(ActionType.Get)
    public List<ForeignInvoiceDTO.Info> getByShipment(Long invoiceTypeId, Long shipmentId, Long currencyId) {

        List<ForeignInvoice> allByContractIdAndInvoiceTypeId = ((ForeignInvoiceDAO) repository).findAllByShipmentIdAndInvoiceTypeId(shipmentId, invoiceTypeId);
        final List<ForeignInvoice> foreignInvoicePI = allByContractIdAndInvoiceTypeId.stream().
                filter(q -> q.getCurrencyId().longValue() != currencyId && (q.getConversionRef() == null || q.getConversionRef().getUnitToId().longValue() != currencyId)).collect(Collectors.toList());

        if (foreignInvoicePI.size() != 0) {

            Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage("", null, locale);
            throw new SalesException2(ErrorType.BadRequest, null, message);
        }

        return modelMapper.map(allByContractIdAndInvoiceTypeId, new TypeToken<List<ForeignInvoiceDTO.Info>>() {
        }.getType());
    }

    @Override
    @Transactional
    @Action(value = ActionType.Get)
    public ContractDetailDataDTO.Info getContractDetailData(Long contractId) {

        ContractDetailDataDTO.Info contractDetailData = new ContractDetailDataDTO.Info();

        Contract contract = contractDAO.findById(contractId).orElseThrow(() -> new NotFoundException(Contract.class));
        Long materialId = contract.getMaterialId();

        // MOAS
        Map<String, List<Object>> operationalDataOfMOASArticle = contractDetailValueService2.get(contractId, EContractDetailTypeCode.QuotationalPeriod, EContractDetailValueKey.MOAS, true);
        if (operationalDataOfMOASArticle.size() != 0) {
            List<Map<String, Object>> moas = (List<Map<String, Object>>) operationalDataOfMOASArticle.get(EContractDetailValueKey.MOAS.getId()).get(0);
            List<ContractDetailDataDTO.MOASData> moasData = new ArrayList<>();
            if (moas != null) moas.stream().forEach(moasItem -> {
                Long materialElementId = Long.valueOf(moasItem.get("materialElement").toString());
                MaterialElement materialElement = materialElementDAO.findById(materialElementId).orElseThrow(() -> new NotFoundException(MaterialElement.class));
                moasItem.put("materialElement", modelMapper.map(materialElement, MaterialElementDTO.Info.class));
                moasData.add(objectMapper.convertValue(moasItem, ContractDetailDataDTO.MOASData.class));
            });
            contractDetailData.setMOAS(moasData);
        } else
            throw new SalesException2(ErrorType.NotFound, "MOAS", "Contract QuotationalPeriod Article Not Found");

        // TC
        Map<String, List<Object>> tcs = contractDetailValueService2.get(contractId, EContractDetailTypeCode.Deduction, EContractDetailValueKey.TC, true);
        if (tcs != null && tcs.size() != 0)
            contractDetailData.setTc(new BigDecimal(tcs.get(EContractDetailValueKey.TC.name()).get(0).toString()));
        else if (materialId == 3)
            throw new SalesException2(ErrorType.NotFound, "rc", "Contract TC Article Not Found");
        else
            contractDetailData.setTc(null);

        // RC
        Map<String, List<Object>> operationalDataOfRCArticle = contractDetailValueService2.get(contractId, EContractDetailTypeCode.Deduction, EContractDetailValueKey.RC, true);
        if (operationalDataOfRCArticle.size() != 0) {
            List<Map<String, Object>> rcs = (List<Map<String, Object>>) operationalDataOfRCArticle.get(EContractDetailValueKey.RC.getId()).get(0);
            List<ContractDetailDataDTO.RCData> rcData = new ArrayList<>();
            if (rcs != null) rcs.stream().forEach(rcItem -> {
                Long financeUnitId = Long.valueOf(rcItem.get("financeUnit").toString());
                Long weightUnitId = Long.valueOf(rcItem.get("weightUnit").toString());
                Long materialElementId = Long.valueOf(rcItem.get("materialElement").toString());
                Unit financeUnit = unitDAO.findById(financeUnitId).orElseThrow(() -> new NotFoundException(UnitDTO.class));
                Unit weightUnit = unitDAO.findById(weightUnitId).orElseThrow(() -> new NotFoundException(UnitDTO.class));
                MaterialElement materialElement = materialElementDAO.findById(materialElementId).orElseThrow(() -> new NotFoundException(MaterialElement.class));
                rcItem.put("financeUnit", modelMapper.map(financeUnit, UnitDTO.Info.class));
                rcItem.put("weightUnit", modelMapper.map(weightUnit, UnitDTO.Info.class));
                rcItem.put("materialElement", modelMapper.map(materialElement, MaterialElementDTO.Info.class));
                rcData.add(objectMapper.convertValue(rcItem, ContractDetailDataDTO.RCData.class));
            });
            contractDetailData.setRc(rcData);
        }
        else if (materialId == 3)
            throw new SalesException2(ErrorType.NotFound, "rc", "Contract RC Article Not Found");
        else
            contractDetailData.setRc(null);

        // INCOTERM
        Map<String, List<Object>> deliveryTerms = contractDetailValueService2.get(contractId, EContractDetailTypeCode.DeliveryTerms, EContractDetailValueKey.INCOTERM, true);
        if (deliveryTerms != null && deliveryTerms.size() != 0)
            contractDetailData.setIncoterm(modelMapper.map(deliveryTerms.get(EContractDetailValueKey.INCOTERM.getId()).get(0), IncotermDTO.Info.class));
        else
            throw new SalesException2(ErrorType.NotFound, "deliveryTerm", "Contract DeliveryTerms Article Not Found");

        // Discounts
        Map<String, List<Object>> operationalDataOfDiscountArticle = contractDetailValueService2.get(contractId, EContractDetailTypeCode.Price, EContractDetailValueKey.DISCOUNT, true);
        List<Object> discounts = operationalDataOfDiscountArticle.get(EContractDetailValueKey.DISCOUNT.getId());
        List<ContractDiscount> discountData = new ArrayList<>();
        if (discounts != null && discounts.size() != 0) {
            discounts.forEach(discount -> discountData.add(modelMapper.map(discount, ContractDiscount.class)));
            contractDetailData.setDiscount(discountData);
        } else
            contractDetailData.setDiscount(null);


        // Price Article Content
        if (materialId != 2) {
            ContractDetailDTO.Info priceDetail = contractDetailService.getContractDetailByContractDetailTypeCode(contractId, materialId, EContractDetailTypeCode.Price);
            if (priceDetail != null) {
                contractDetailData.setPriceContent(priceDetail.getContent());
            }
        } else
            contractDetailData.setPriceContent(null);

        // QuotationalPeriod Article Content
        ContractDetailDTO.Info quotationalPeriodDetail = contractDetailService.getContractDetailByContractDetailTypeCode(contractId, materialId, EContractDetailTypeCode.QuotationalPeriod);
        if (quotationalPeriodDetail != null) {
            contractDetailData.setQuotationalPeriodContent(quotationalPeriodDetail.getContent());
        }

        return contractDetailData;
    }

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ForeignInvoiceDTO.Info create(ForeignInvoiceDTO.Create request) {

        PersianCalendar calendar = new PersianCalendar(request.getDate());
        ContractDTO.Info contract = contractService.get(request.getContractId());
        InvoiceTypeDTO.Info invoiceType = invoiceTypeService.get(request.getInvoiceTypeId());
        request.setNo(invoiceNoGenerator.createInvoiceNo(invoiceType.getTitle(), calendar.get(Calendar.YEAR) % 100, calendar.get(Calendar.MONTH) + 1, contract.getMaterial().getAbbreviation(), contract.getNo()));

        ForeignInvoiceDTO.Info foreignInvoice = super.create(request);

        request.getForeignInvoiceItems().forEach(item -> {

            ForeignInvoiceItemDTO.Create foreignInvoiceItemCreate = modelMapper.map(item, ForeignInvoiceItemDTO.Create.class);
            foreignInvoiceItemCreate.setForeignInvoiceId(foreignInvoice.getId());
            ForeignInvoiceItemDTO.Info foreignInvoiceItem = foreignInvoiceItemService.create(foreignInvoiceItemCreate);
            if (item.getForeignInvoiceItemDetails() != null) {
                item.getForeignInvoiceItemDetails().forEach(detail -> {

                    ForeignInvoiceItemDetailDTO.Create foreignInvoiceItemDetailCreate = modelMapper.map(detail, ForeignInvoiceItemDetailDTO.Create.class);
                    foreignInvoiceItemDetailCreate.setForeignInvoiceItemId(foreignInvoiceItem.getId());
                    foreignInvoiceItemDetailService.create(foreignInvoiceItemDetailCreate);
                });
            }
        });

        request.getForeignInvoicePayments().forEach(item -> item.setForeignInvoiceId(foreignInvoice.getId()));
        foreignInvoicePaymentService.createAll(modelMapper.map(request.getForeignInvoicePayments(), new TypeToken<List<ForeignInvoicePaymentDTO.Create>>() {
        }.getType()));

        request.getBillLadingIds().forEach(item -> {
            ForeignInvoiceBillOfLandingDTO.Create foreignInvoiceBillOfLanding = new ForeignInvoiceBillOfLandingDTO.Create();
            foreignInvoiceBillOfLanding.setBillOfLandingId(item);
            foreignInvoiceBillOfLanding.setForeignInvoiceId(foreignInvoice.getId());
            foreignInvoiceBillOfLadingService.create(foreignInvoiceBillOfLanding);
        });

        return foreignInvoice;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ForeignInvoiceDTO.Info update(Long id, ForeignInvoiceDTO.Update request) {

        ForeignInvoice foreignInvoice = repository.findById(id).orElseThrow(() -> new NotFoundException(ForeignInvoice.class));

        int itemSize = foreignInvoice.getForeignInvoiceItems().size();
        for (int i = 0; i < itemSize; i++) {
            ForeignInvoiceItem foreignInvoiceItem = foreignInvoice.getForeignInvoiceItems().get(i);
            if (foreignInvoiceItem.getForeignInvoiceItemDetails() != null) {
                int itemDetailSize = foreignInvoiceItem.getForeignInvoiceItemDetails().size();
                for (int j = 0; j < itemDetailSize; j++) {
                    foreignInvoiceItemDetailService.delete(foreignInvoiceItem.getForeignInvoiceItemDetails().get(j).getId());
                }
            }
            foreignInvoiceItemService.delete(foreignInvoice.getForeignInvoiceItems().get(i).getId());
        }

        foreignInvoice.getForeignInvoicePayments().forEach(item -> foreignInvoicePaymentService.delete(item.getId()));

        int billLadingSize = request.getBillLadingIds().size();
        for (int i = 0; i < billLadingSize; i++) {
            List<ForeignInvoiceBillOfLading> allByBillOfLandingIdAAndForeignInvoiceId = foreignInvoiceBillOfLadingDAO.findAllByBillOfLandingIdAndForeignInvoiceId(request.getBillLadingIds().get(i), foreignInvoice.getId());
            for (int j = 0; j < allByBillOfLandingIdAAndForeignInvoiceId.size(); j++) {
                foreignInvoiceBillOfLadingService.delete(allByBillOfLandingIdAAndForeignInvoiceId.get(j).getId());
            }
        }

        ForeignInvoiceDTO.Info foreignInvoiceDTO = super.update(id, request);
        foreignInvoice.setBillLadings(null);

        request.getForeignInvoiceItems().forEach(item -> {
            ForeignInvoiceItemDTO.Create foreignInvoiceItemCreate = modelMapper.map(item, ForeignInvoiceItemDTO.Create.class);
            foreignInvoiceItemCreate.setForeignInvoiceId(foreignInvoice.getId());
            ForeignInvoiceItemDTO.Info foreignInvoiceItem = foreignInvoiceItemService.create(foreignInvoiceItemCreate);
            if (item.getForeignInvoiceItemDetails() != null) {
                item.getForeignInvoiceItemDetails().forEach(detail -> {
                    ForeignInvoiceItemDetailDTO.Create foreignInvoiceItemDetailCreate = modelMapper.map(detail, ForeignInvoiceItemDetailDTO.Create.class);
                    foreignInvoiceItemDetailCreate.setForeignInvoiceItemId(foreignInvoiceItem.getId());
                    foreignInvoiceItemDetailService.create(foreignInvoiceItemDetailCreate);
                });
            }
        });

        request.getForeignInvoicePayments().forEach(item -> item.setForeignInvoiceId(foreignInvoice.getId()));
        foreignInvoicePaymentService.createAll(modelMapper.map(request.getForeignInvoicePayments(), new TypeToken<List<ForeignInvoicePaymentDTO.Create>>() {
        }.getType()));

        request.getBillLadingIds().forEach(item -> {
            ForeignInvoiceBillOfLandingDTO.Create foreignInvoiceBillOfLanding = new ForeignInvoiceBillOfLandingDTO.Create();
            foreignInvoiceBillOfLanding.setBillOfLandingId(item);
            foreignInvoiceBillOfLanding.setForeignInvoiceId(foreignInvoice.getId());
            foreignInvoiceBillOfLadingService.create(foreignInvoiceBillOfLanding);
        });

        return foreignInvoiceDTO;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Finalize)
    public ForeignInvoiceDTO.Info finalize(Long id) {

        ForeignInvoiceDTO.Info finalize = super.finalize(id);

        List<ForeignInvoice> foreignInvoices = ((ForeignInvoiceDAO) repository).findAllByParentId(id);
        List<Long> foreignInvoiceIds = foreignInvoices.stream().map(ForeignInvoice::getId).collect(Collectors.toList());
        foreignInvoiceIds.forEach(item -> super.finalize(item));

        return finalize;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Disapprove)
    public ForeignInvoiceDTO.Info disapprove(Long id) {

        ForeignInvoiceDTO.Info disapprove = super.disapprove(id);

        List<ForeignInvoice> foreignInvoices = ((ForeignInvoiceDAO) repository).findAllByParentId(id);
        List<Long> foreignInvoiceIds = foreignInvoices.stream().map(ForeignInvoice::getId).collect(Collectors.toList());
        foreignInvoiceIds.forEach(item -> super.disapprove(item));

        return disapprove;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Activate)
    public ForeignInvoiceDTO.Info activate(Long id) {

        ForeignInvoiceDTO.Info activate = super.activate(id);

        List<ForeignInvoice> foreignInvoices = ((ForeignInvoiceDAO) repository).findAllByParentId(id);
        List<Long> foreignInvoiceIds = foreignInvoices.stream().map(ForeignInvoice::getId).collect(Collectors.toList());
        foreignInvoiceIds.forEach(item -> super.activate(item));

        return activate;
    }

    @Override
    @Transactional
    @Action(value = ActionType.DeActivate)
    public ForeignInvoiceDTO.Info deactivate(Long id) {

        ForeignInvoiceDTO.Info deactivate = super.deactivate(id);

        List<ForeignInvoice> foreignInvoices = ((ForeignInvoiceDAO) repository).findAllByParentId(id);
        List<Long> foreignInvoiceIds = foreignInvoices.stream().map(ForeignInvoice::getId).collect(Collectors.toList());
        foreignInvoiceIds.forEach(item -> super.deactivate(item));

        return deactivate;
    }
}
