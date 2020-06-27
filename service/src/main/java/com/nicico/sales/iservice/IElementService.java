package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ElementDTO;

import java.util.List;

public interface IElementService {

    ElementDTO.Info get(Long id);

    List<ElementDTO.Info> list();

    ElementDTO.Info create(ElementDTO.Create request);

    ElementDTO.Info update(Long id, ElementDTO.Update request);

    void delete(Long id);

    void deleteAll(ElementDTO.Delete request);

    TotalResponse<ElementDTO.Info> search(NICICOCriteria criteria);
}
