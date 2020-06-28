package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.model.entities.warehouse.Warehouse;

import java.util.List;

public interface IWarehouseService {

    Warehouse get(Long id);

    List<Warehouse> list();

    TotalResponse<Warehouse> search(NICICOCriteria request);


    void updateFromTozinView();


}
