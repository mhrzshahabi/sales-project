package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.model.entities.warehouse.ItemDetail;

import java.util.List;

public interface IItemDetailService {

    ItemDetail get(Long id);

    List<ItemDetail> list();

    TotalResponse<ItemDetail> search(NICICOCriteria request);

    SearchDTO.SearchRs<ItemDetail> search(SearchDTO.SearchRq request);

}
