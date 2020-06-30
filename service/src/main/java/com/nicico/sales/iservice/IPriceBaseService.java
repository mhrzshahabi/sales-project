package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ElementDTO;
import com.nicico.sales.dto.PriceBaseDTO;

import java.util.List;

public interface IPriceBaseService {

    PriceBaseDTO.Info get(Long id);

    List<PriceBaseDTO.Info> list();

    PriceBaseDTO.Info create(PriceBaseDTO.Create request);

    PriceBaseDTO.Info update(Long id, PriceBaseDTO.Update request);

    void delete(Long id);

    void deleteAll(PriceBaseDTO.Delete request);

    TotalResponse<PriceBaseDTO.Info> search(NICICOCriteria criteria);

    List<ElementDTO.ElementPriceBaseDTO> getElementBasePrices(Integer year, Integer month, Long materialId);
}
