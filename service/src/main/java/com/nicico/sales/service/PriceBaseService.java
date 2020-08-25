package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IPriceBaseService;
import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import com.nicico.sales.repository.PriceBaseDAO;
import com.nicico.sales.repository.warehouse.MaterialElementDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PriceBaseService extends GenericService<PriceBase, Long, PriceBaseDTO.Create, PriceBaseDTO.Info, PriceBaseDTO.Update, PriceBaseDTO.Delete> implements IPriceBaseService {

    private final MaterialElementDAO materialElementDAO;

    @Action(value = ActionType.Get)
    @Transactional
    @Override
    public List<PriceBaseDTO.Info> getElementBasePrices(PriceBaseReference reference, Integer year, Integer month, Long materialId) {

        List<MaterialElement> materialElements = materialElementDAO.findAllByMaterialId(materialId);
        List<Long> elementIds = materialElements.stream().map(MaterialElement::getElementId).collect(Collectors.toList());

        List<PriceBase> pricesByElements = ((PriceBaseDAO) repository).getAllPricesByElements(reference, year, month, elementIds);
        return modelMapper.map(pricesByElements, new TypeToken<List<PriceBaseDTO.Info>>() {
        }.getType());
    }
}
