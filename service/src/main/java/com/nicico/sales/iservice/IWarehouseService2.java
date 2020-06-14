package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseDTO;

import java.util.List;

public interface IWarehouseService2 {
    void updateFromTozinView();

    WarehouseDTO.Info get(Long id);

    List<WarehouseDTO.Info> list();

    TotalResponse<WarehouseDTO.Info> search(NICICOCriteria nicicoCriteria);

}
