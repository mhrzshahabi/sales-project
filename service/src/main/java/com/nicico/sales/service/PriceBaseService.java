package com.nicico.sales.service;

import com.nicico.sales.dto.HRMDTO;
import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IHRMApiService;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.repository.PriceBaseDAO;
import com.nicico.sales.repository.contract.ContractDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.math.MathContext;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<com.nicico.sales.model.entities.base.PriceBase, Long, com.nicico.sales.dto.PriceBaseDTO.Create, com.nicico.sales.dto.PriceBaseDTO.Info, com.nicico.sales.dto.PriceBaseDTO.Update, com.nicico.sales.dto.PriceBaseDTO.Delete> implements IPriceBaseService {

    private int year;
    private int month;

    private final ContractDAO contractDAO;
    private final IHRMApiService hrmApiService;
    private final MaterialElementDAO materialElementDAO;

    public List<PriceBaseDTO.Info> getAverageOfBasePricesByMOAS(Long contractId, Date sendDate, Long financeUnitId, List<ContractDetailDataDTO.MOASData> moasData) {

        Contract contract = contractDAO.findById(contractId).orElseThrow(() -> new NotFoundException(Contract.class));
        List<MaterialElement> materialElements = materialElementDAO.findAllByMaterialId(contract.getMaterialId());
        List<MaterialElement> validMaterialElements = materialElements.stream().filter(materialElement -> materialElement.getPayable() || materialElement.getPenalty()).collect(Collectors.toList());
        List<ContractDetailDataDTO.MOASData> validMOASData = moasData.stream().filter(moas -> validMaterialElements.stream().anyMatch(q -> q.getId().longValue() == moas.getMaterialElement().getId())).collect(Collectors.toList());

        List<PriceBase> pricesByElements = new ArrayList<>();

        if (validMOASData.size() == validMaterialElements.size()) {
            validMOASData.forEach(item -> {

                Calendar calendar = Calendar.getInstance();
                calendar.setTime(sendDate);
                MaterialElement materialElement = validMaterialElements.stream().filter(q -> q.getId().longValue() == item.getMaterialElement().getId()).findFirst().get();
                if (item.getMoasValue() != null) {

                    if (calendar.get(Calendar.MONTH) + 1 + item.getMoasValue() > 12) {
                        month = calendar.get(Calendar.MONTH) + 1 + item.getMoasValue() - 12;
                        year = calendar.get(Calendar.YEAR) + 1;
                    } else {
                        month = calendar.get(Calendar.MONTH) + 1 + item.getMoasValue();
                        year = calendar.get(Calendar.YEAR);
                    }
                    pricesByElements.addAll(((PriceBaseDAO) repository).getAllPricesByElements(item.getPriceReference(), year,
                            month, materialElement.getElementId(), financeUnitId));
                }
                else if (item.getWorkingDayAfter() != null && item.getWorkingDayBefore() != null) {

                    HRMDTO.BusinessDaysRq businessDaysRq = new HRMDTO.BusinessDaysRq();
                    businessDaysRq.setType(2);
                    businessDaysRq.setDate(item.getDate());
                    businessDaysRq.setAfter(item.getWorkingDayAfter());
                    businessDaysRq.setBefore(item.getWorkingDayBefore());
                    try {
                        HRMDTO.BusinessDaysInfo businessDays = hrmApiService.getBusinessDays(businessDaysRq);
                        List<HRMDTO.DayInfo> dayInfos = new ArrayList<>(businessDays.getAfter());
                        dayInfos.add(businessDays.getToday());
                        dayInfos.addAll(businessDays.getBefore());

                        List<String> workingDays = dayInfos.stream().map(dayInfo -> new SimpleDateFormat("YYYY-MM-dd").format(dayInfo.getTimestamp())).collect(Collectors.toList());
                        pricesByElements.addAll(((PriceBaseDAO) repository).getAllPricesByElements(item.getPriceReference(), workingDays, materialElement.getElementId(), financeUnitId));
                    } catch (Exception e) {
                        throw new SalesException2(ErrorType.Forbidden, "businessDays", "No Access to HRM System");
                    }
                }
                else
                    throw new SalesException2(ErrorType.InvalidData, "MOASValue", "Data is not Complete");
            });
            Set<Long> pricesByElementIds = pricesByElements.stream().map(PriceBase::getElementId).collect(Collectors.toSet());
            if (pricesByElementIds.size() == 0)
                throw new SalesException2(ErrorType.NotFound, "PriceBase", "Price Base Does not Exist");

            if (!pricesByElementIds.containsAll(validMaterialElements.stream().map(MaterialElement::getElementId).collect(Collectors.toList())))
                throw new NotFoundException(PriceBase.class);

            Map<Long, List<PriceBase>> pricesByElementGroup = pricesByElements.stream().collect(Collectors.groupingBy(PriceBase::getElementId));
            List<PriceBaseDTO.Info> priceBases = new ArrayList<>();
            pricesByElementGroup.keySet().forEach(elementId -> {

                List<PriceBase> groupPriceBases = pricesByElementGroup.get(elementId);
                Set<@NotNull Long> weightUnitIdSet = groupPriceBases.stream().map(PriceBase::getWeightUnitId).collect(Collectors.toSet());
                if (weightUnitIdSet.size() > 1)
                    throw new SalesException2(ErrorType.BadRequest, "WeightUnit", "Weight unit is multiple for an Element");

                PriceBaseDTO.Info priceBase = modelMapper.map(groupPriceBases.get(0), PriceBaseDTO.Info.class);
                BigDecimal groupAveragePrice = groupPriceBases.stream().map(PriceBase::getPrice).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(groupPriceBases.size()), MathContext.DECIMAL32);
                priceBase.setPrice(groupAveragePrice);
                priceBase.setId(null);

                priceBases.add(priceBase);
            });

            if (priceBases.size() == 0) throw new NotFoundException(PriceBase.class);

            return priceBases;
        } else throw new SalesException2(ErrorType.NotFound, "MOAS", "MOAS Data in Contract is not Complete");

    }
}
