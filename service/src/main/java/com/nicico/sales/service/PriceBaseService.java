package com.nicico.sales.service;

import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.repository.PriceBaseDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<com.nicico.sales.model.entities.base.PriceBase, Long, com.nicico.sales.dto.PriceBaseDTO.Create, com.nicico.sales.dto.PriceBaseDTO.Info, com.nicico.sales.dto.PriceBaseDTO.Update, com.nicico.sales.dto.PriceBaseDTO.Delete> implements IPriceBaseService {

    private final MaterialElementDAO materialElementDAO;

    @Override
    public List<PriceBaseDTO.Info> getAverageOfElementBasePrices(PriceBaseReference reference, Integer year, Integer month, Long materialId) {

        List<MaterialElement> materialElements = materialElementDAO.findAllByMaterialId(materialId);
        List<Long> elementIds = materialElements.stream().map(MaterialElement::getElementId).collect(Collectors.toList());

        List<PriceBase> pricesByElements = ((PriceBaseDAO) repository).getAllPricesByElements(reference, year, month, elementIds);
        Map<Long, List<PriceBase>> pricesByElementGroup = pricesByElements.stream().collect(Collectors.groupingBy(PriceBase::getElementId));
        List<PriceBaseDTO.Info> priceBases = new ArrayList<>();
        pricesByElementGroup.keySet().forEach(elementId -> {

            List<PriceBase> groupPriceBases = pricesByElementGroup.get(elementId);
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
