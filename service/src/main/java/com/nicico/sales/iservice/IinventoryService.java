package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.InventoryDTO;

import java.util.List;

public interface IinventoryService {

    InventoryDTO.Info get(Long id);

    List<InventoryDTO.Info> getAll(List<Long> ids);

    List<InventoryDTO.Info> list();

    InventoryDTO.Info create(InventoryDTO.Create request);

    List<InventoryDTO.Info> createAll(List<InventoryDTO.Create> requests);

    InventoryDTO.Info update(InventoryDTO.Update request);

    InventoryDTO.Info update(Long id, InventoryDTO.Update request);

    List<InventoryDTO.Info> updateAll(List<InventoryDTO.Update> requests);

    List<InventoryDTO.Info> updateAll(List<Long> ids, List<InventoryDTO.Update> requests);

    void delete(Long id);

    void deleteAll(InventoryDTO.Delete request);

    TotalResponse<InventoryDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<InventoryDTO.Info> search(SearchDTO.SearchRq request);
}
