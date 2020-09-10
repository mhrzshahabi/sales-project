package com.nicico.sales.service;

import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.repository.PriceBaseDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<com.nicico.sales.model.entities.base.PriceBase, Long, com.nicico.sales.dto.PriceBaseDTO.Create, com.nicico.sales.dto.PriceBaseDTO.Info, com.nicico.sales.dto.PriceBaseDTO.Update, com.nicico.sales.dto.PriceBaseDTO.Delete> implements IPriceBaseService {

    private final MaterialElementDAO materialElementDAO;

    @Override
    public List<PriceBaseDTO.Info> getAverageOfElementBasePrices(PriceBaseReference reference, Integer year, Integer month, Long materialId, Long financeUnitId) {

        List<MaterialElement> materialElements = materialElementDAO.findAllByMaterialId(materialId);
        List<Long> elementIds = materialElements.stream().filter(materialElement -> materialElement.getElement().getPayable()).map(MaterialElement::getElementId).collect(Collectors.toList());

        List<PriceBase> pricesByElements = ((PriceBaseDAO) repository).getAllPricesByElements(reference, year, month, elementIds);
        Set<Long> pricesByElementIds = pricesByElements.stream().map(PriceBase::getElementId).collect(Collectors.toSet());

        if (!pricesByElementIds.containsAll(elementIds))
            throw new NotFoundException(PriceBase.class);

        Map<Long, List<PriceBase>> pricesByElementGroup = pricesByElements.stream().collect(Collectors.groupingBy(PriceBase::getElementId));
        List<PriceBaseDTO.Info> priceBases = new ArrayList<>();
        pricesByElementGroup.keySet().forEach(elementId -> {

            List<PriceBase> groupPriceBases = pricesByElementGroup.get(elementId);
            Set<@NotNull Long> weightUnitIdSet = groupPriceBases.stream().map(PriceBase::getWeightUnitId).collect(Collectors.toSet());
            if (weightUnitIdSet.size() > 1) throw new SalesException2(ErrorType.BadRequest, "WeightUnit","Weight unit is multiple.");
            Set<@NotNull Long> financeUnitIdSet = groupPriceBases.stream().map(PriceBase::getFinanceUnitId).collect(Collectors.toSet());
            if (financeUnitIdSet.size() > 1) throw new SalesException2(ErrorType.BadRequest, "FinanceUnit","Finance unit is multiple.");

            if(financeUnitId != groupPriceBases.get(0).getFinanceUnitId().longValue()) throw new SalesException2(ErrorType.BadRequest, "FinanceUnit","Finance unit is not match.");

            PriceBaseDTO.Info priceBase = modelMapper.map(groupPriceBases.get(0), PriceBaseDTO.Info.class);
            BigDecimal groupAveragePrice = groupPriceBases.stream().map(PriceBase::getPrice).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(groupPriceBases.size()), RoundingMode.HALF_EVEN);
            priceBase.setPrice(groupAveragePrice);
            priceBase.setId(null);

            priceBases.add(priceBase);
        });


        if (priceBases.size() == 0) throw new NotFoundException(PriceBase.class);

        return priceBases;
    }
}
