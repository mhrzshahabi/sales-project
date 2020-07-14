package com.nicico.sales.service;

import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.warehouse.Element;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.repository.PriceBaseDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<com.nicico.sales.model.entities.base.PriceBase, Long, com.nicico.sales.dto.PriceBaseDTO.Create, com.nicico.sales.dto.PriceBaseDTO.Info, com.nicico.sales.dto.PriceBaseDTO.Update, com.nicico.sales.dto.PriceBaseDTO.Delete> implements IPriceBaseService {

    private final MaterialElementDAO materialElementDAO;

    @Override
    public List<PriceBaseDTO.Info> getElementBasePrices(PriceBaseReference reference, Integer year, Integer month, Long materialId) {

        List<MaterialElement> materialElements = materialElementDAO.findAllByMaterialId(materialId);
        List<Long> elementIds = materialElements.stream().map(MaterialElement::getElementId).collect(Collectors.toList());

        List<PriceBase> pricesByElements = ((PriceBaseDAO) repository).getAllPricesByElements(reference, year, month, elementIds);
        pricesByElements.stream().filter(price -> {

            @SuppressWarnings("OptionalGetWithoutIsPresent")
            Element elm = materialElements.stream().
                    map(MaterialElement::getElement).
                    filter(element -> element.getId() == price.getElementId().longValue()).
                    findFirst().get();
            price.getUnitId() == elm.getUnitId();
        });

        return modelMapper.map(pricesByElements,
                new TypeToken<List<PriceBaseDTO.Info>>() {
                }.getType());
    }
}
