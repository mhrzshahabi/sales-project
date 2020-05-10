package com.nicico.sales.iservice.warehous;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.model.entities.warehouse.RemittanceType;

import java.util.List;

public interface IRemittanceTypeService {

    RemittanceType get(Long id);

    List<RemittanceType> list();

    TotalResponse<RemittanceType> search(NICICOCriteria request);

    SearchDTO.SearchRs<RemittanceType> search(SearchDTO.SearchRq request);

}
