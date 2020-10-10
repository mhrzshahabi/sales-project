package com.nicico.sales.service.invoice.foreign;

import com.ghasemkiani.util.icu.PersianCalendar;
import com.ibm.icu.util.Calendar;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InvoiceTypeDTO;
import com.nicico.sales.dto.contract.ContractDTO;
import com.nicico.sales.dto.contract.IncotermDTO;
import com.nicico.sales.dto.invoice.foreign.*;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IContractDetailValueService2;
import com.nicico.sales.iservice.invoice.foreign.IForeignInvoiceService;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceBillOfLading;
import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItem;
import com.nicico.sales.repository.contract.ContractDAO;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceBillOfLadingDAO;
import com.nicico.sales.repository.invoice.foreign.ForeignInvoiceDAO;
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
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ForeignInvoiceService extends GenericService<ForeignInvoice, Long, ForeignInvoiceDTO.Create, ForeignInvoiceDTO.Info, ForeignInvoiceDTO.Update, ForeignInvoiceDTO.Delete> implements IForeignInvoiceService {

    private final ContractService contractService;
    private final InvoiceTypeService invoiceTypeService;
    private final InvoiceNoGenerator invoiceNoGenerator;
    private final ResourceBundleMessageSource messageSource;
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
    public ForeignInvoiceDTO.ContractDetailData getContractDetailData(Long contractId) {

        ForeignInvoiceDTO.ContractDetailData contractDetailData = new ForeignInvoiceDTO.ContractDetailData();

//        Contract contract = contractDAO.findById(contractId).orElseThrow(() -> new NotFoundException(Contract.class));
//        Long materialId = contract.getMaterialId();
//        if (materialId == ) {}

        Map<String, List<Object>> moases = contractDetailValueService2.get(contractId, EContractDetailTypeCode.QuotationalPeriod, EContractDetailValueKey.MOAS, true);
        if (moases != null)
            contractDetailData.setMOASValue(modelMapper.map(moases.get(EContractDetailValueKey.MOAS.name()), new TypeToken<List<ForeignInvoiceDTO.MOASData>>() {
            }.getType()));

        Map<String, List<Object>> rcs = contractDetailValueService2.get(contractId, EContractDetailTypeCode.Deduction, EContractDetailValueKey.RC, true);
        Map<String, List<Object>> tcs = contractDetailValueService2.get(contractId, EContractDetailTypeCode.Deduction, EContractDetailValueKey.TC, true);
        if (tcs != null)
            contractDetailData.setTc(new BigDecimal(tcs.get(EContractDetailValueKey.TC.name()).get(0).toString()));
        if (rcs != null)
            contractDetailData.setRc(modelMapper.map(rcs.get(EContractDetailValueKey.RC.name()), new TypeToken<List<ForeignInvoiceDTO.RCData>>() {
            }.getType()));

        Map<String, List<Object>> deliveryTerms = contractDetailValueService2.get(contractId, EContractDetailTypeCode.DeliveryTerms, EContractDetailValueKey.INCOTERM, true);
        if (deliveryTerms != null)
            contractDetailData.setIncoterm(modelMapper.map(deliveryTerms.get(EContractDetailValueKey.INCOTERM.name()), IncotermDTO.Info.class));

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
    @Action(ActionType.Delete)
    public void delete(Long aLong) {
    }

    @Override
    @Transactional
    @Action(ActionType.DeleteAll)
    public void deleteAll(ForeignInvoiceDTO.Delete request) {
    }
}
