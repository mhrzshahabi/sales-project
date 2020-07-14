package com.nicico.sales.service;

import com.nicico.sales.dto.ElementDTO;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.repository.PriceBaseDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<com.nicico.sales.model.entities.base.PriceBase, Long, com.nicico.sales.dto.PriceBaseDTO.Create, com.nicico.sales.dto.PriceBaseDTO.Info, com.nicico.sales.dto.PriceBaseDTO.Update, com.nicico.sales.dto.PriceBaseDTO.Delete> implements IPriceBaseService {

    private final MaterialElementDAO materialElementDAO;

    @Override
    public List<ElementDTO.ElementPriceBaseDTO> getElementBasePrices(Integer year, Integer month, Long materialId) {

        List<MaterialElement> materialElements = materialElementDAO.findAllByMaterialId(materialId);
        List<Long> elementIds = materialElements.stream().map(MaterialElement::getElementId).collect(Collectors.toList());

        List<PriceBase> prices = ((PriceBaseDAO) repository).getAllPricesByElements(year, month, elementIds);
        Collection<ElementDTO.ElementPriceBaseDTO> groups = prices.stream().collect(Collectors.groupingBy(PriceBase::getElementId, Collectors.collectingAndThen(Collectors.toList(), q -> {

            if (q.size() == 0)
                return new ElementDTO.ElementPriceBaseDTO();

            BigDecimal averagePrice = q.stream().map(PriceBase::getPrice).reduce(BigDecimal.ZERO, BigDecimal::add).divide(BigDecimal.valueOf(q.size()), RoundingMode.HALF_EVEN);
            ElementDTO.ElementPriceBaseDTO result = modelMapper.map(q.get(0).getElement(), ElementDTO.ElementPriceBaseDTO.class);
            result.setPrice(averagePrice);
            result.setUnit(q.get(0).getUnit());
            result.setCurrency(q.get(0).getUnit());

            return result;
        }))).values();

        return new ArrayList<>(groups);
    }
}
