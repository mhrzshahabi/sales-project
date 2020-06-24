package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.model.entities.warehouse.Item;

import java.util.List;

public interface IItemService {
    void updateFromTozinView();

    Item get(Long id);

    List<Item> list();

    TotalResponse<Item> search(NICICOCriteria nicicoCriteria);

}
