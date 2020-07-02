package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseDTO;

import java.util.List;

public interface IWarehouseService {

    WarehouseDTO.Info get(Long id);

    List<WarehouseDTO.Info> list();

    TotalResponse<WarehouseDTO.Info> search(NICICOCriteria request);


    void updateFromTozinView();


}
