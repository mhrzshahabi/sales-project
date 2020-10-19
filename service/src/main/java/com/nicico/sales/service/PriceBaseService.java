package com.nicico.sales.service;

import com.nicico.sales.dto.HRMDTO;
import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IContractDetailValueService2;
import com.nicico.sales.iservice.IHRMApiService;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.repository.PriceBaseDAO;
import com.nicico.sales.repository.contract.ContractDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.math.MathContext;
import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<com.nicico.sales.model.entities.base.PriceBase, Long, com.nicico.sales.dto.PriceBaseDTO.Create, com.nicico.sales.dto.PriceBaseDTO.Info, com.nicico.sales.dto.PriceBaseDTO.Update, com.nicico.sales.dto.PriceBaseDTO.Delete> implements IPriceBaseService {

    private final ContractDAO contractDAO;
    private final MaterialElementDAO materialElementDAO;
    private final IHRMApiService hrmApiService;
    private final IContractDetailValueService2 contractDetailValueService2;

    @Override
    public List<PriceBaseDTO.Info> getAverageOfElementBasePrices(Long contractId, Long financeUnitId, Date sendDate) {

        Map<String, List<Object>> operationalDataOfMOASArticle = contractDetailValueService2.get(contractId, EContractDetailTypeCode.QuotationalPeriod, EContractDetailValueKey.MOAS, true);
        List<Object> moas = operationalDataOfMOASArticle.get(EContractDetailValueKey.MOAS.getId());
        if (moas == null) return new ArrayList<>();
        else {

            List<ContractDetailDataDTO.MOASData> moasData = modelMapper.map(moas, new TypeToken<List<ContractDetailDataDTO.MOASData>>() {
            }.getType());
            return getAverageOfBasePricesByMOAS(contractId, financeUnitId, moasData);
        }
    }

    private List<PriceBaseDTO.Info> getAverageOfBasePricesByMOAS(Long contractId, Long financeUnitId, List<ContractDetailDataDTO.MOASData> moasData) {

        Contract contract = contractDAO.findById(contractId).orElseThrow(() -> new NotFoundException(Contract.class));
        List<MaterialElement> materialElements = materialElementDAO.findAllByMaterialId(contract.getMaterialId());
        List<MaterialElement> validMaterialElements = materialElements.stream().filter(materialElement -> materialElement.getPayable() || materialElement.getPenalty()).collect(Collectors.toList());
        List<ContractDetailDataDTO.MOASData> validMOASData = moasData.stream().filter(moas -> validMaterialElements.stream().anyMatch(q -> q.getId().longValue() == moas.getMaterialElementId())).collect(Collectors.toList());

        List<PriceBase> pricesByElements = new ArrayList<>();
        validMOASData.forEach(item -> {

            MaterialElement materialElement = validMaterialElements.stream().filter(q -> q.getId().longValue() == item.getMaterialElementId()).findFirst().get();
            if (item.getValue() != null)
                pricesByElements.addAll(((PriceBaseDAO) repository).getAllPricesByElements(item.getPriceReference(), item.getDate().getYear(), item.getDate().getMonth() + 1 + item.getValue(), materialElement.getElementId()));
            else if (item.getWorkingDayAfter() != null && item.getWorkingDayBefore() != null) {

//                List<Date> workingDays = new ArrayList<>();
                HRMDTO.BusinessDaysRq businessDaysRq = new HRMDTO.BusinessDaysRq();
                businessDaysRq.setType(2);
                businessDaysRq.setDate(item.getDate());
                businessDaysRq.setAfter(item.getWorkingDayAfter());
                businessDaysRq.setBefore(item.getWorkingDayBefore());
                HRMDTO.BusinessDaysInfo businessDays = hrmApiService.getBusinessDays(businessDaysRq);

                List<HRMDTO.DayInfo> dayInfos = new ArrayList<>();
                dayInfos.addAll(businessDays.getAfter());
                dayInfos.add(businessDays.getToday());
                dayInfos.addAll(businessDays.getBefore());

                List<Date> workingDays = dayInfos.stream().map(q -> q.getTimestamp()).collect(Collectors.toList());
                pricesByElements.addAll(((PriceBaseDAO) repository).getAllPricesByElements(item.getPriceReference(), workingDays, materialElement.getElementId()));
            } else throw new SalesException2();
        });
        Set<Long> pricesByElementIds = pricesByElements.stream().map(PriceBase::getElementId).collect(Collectors.toSet());

        if (!pricesByElementIds.containsAll(validMaterialElements.stream().map(MaterialElement::getElementId).collect(Collectors.toList())))
            throw new NotFoundException(PriceBase.class);

        Map<Long, List<PriceBase>> pricesByElementGroup = pricesByElements.stream().collect(Collectors.groupingBy(PriceBase::getElementId));
        List<PriceBaseDTO.Info> priceBases = new ArrayList<>();
        pricesByElementGroup.keySet().forEach(elementId -> {

            List<PriceBase> groupPriceBases = pricesByElementGroup.get(elementId);
            Set<@NotNull Long> weightUnitIdSet = groupPriceBases.stream().map(PriceBase::getWeightUnitId).collect(Collectors.toSet());
            if (weightUnitIdSet.size() > 1)
                throw new SalesException2(ErrorType.BadRequest, "WeightUnit", "Weight unit is multiple.");
            Set<@NotNull Long> financeUnitIdSet = groupPriceBases.stream().map(PriceBase::getFinanceUnitId).collect(Collectors.toSet());
            if (financeUnitIdSet.size() > 1)
                throw new SalesException2(ErrorType.BadRequest, "FinanceUnit", "Finance unit is multiple.");

            if (financeUnitId != groupPriceBases.get(0).getFinanceUnitId().longValue())
                throw new SalesException2(ErrorType.BadRequest, "FinanceUnit", "Finance unit is not match.");

            PriceBaseDTO.Info priceBase = modelMapper.map(groupPriceBases.get(0), PriceBaseDTO.Info.class);
            BigDecimal groupAveragePrice = groupPriceBases.stream().map(PriceBase::getPrice).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(groupPriceBases.size()), MathContext.DECIMAL32);
            priceBase.setPrice(groupAveragePrice);
            priceBase.setId(null);

            priceBases.add(priceBase);
        });


        if (priceBases.size() == 0) throw new NotFoundException(PriceBase.class);

        return priceBases;
    }
}
