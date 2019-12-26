package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseStockDTO;

import java.util.List;

public interface IWarehouseStockService {

    WarehouseStockDTO.Info get(Long id);

    List<WarehouseStockDTO.Info> list();

    WarehouseStockDTO.Info create(WarehouseStockDTO.Create request);

    WarehouseStockDTO.Info update(Long id, WarehouseStockDTO.Update request);

    void delete(Long id);

    void delete(WarehouseStockDTO.Delete request);

    TotalResponse<WarehouseStockDTO.Info> search(NICICOCriteria criteria);

    SearchDTO.SearchRs<WarehouseStockDTO.Info> search(SearchDTO.SearchRq request);

    List<Object[]> warehouseStockConc();
}
