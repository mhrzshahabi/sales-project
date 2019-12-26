package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseIssueConsDTO;

import java.util.List;

public interface IWarehouseIssueConsService {

    WarehouseIssueConsDTO.Info get(Long id);

    List<WarehouseIssueConsDTO.Info> list();

    WarehouseIssueConsDTO.Info create(WarehouseIssueConsDTO.Create request);

    WarehouseIssueConsDTO.Info update(Long id, WarehouseIssueConsDTO.Update request);

    void delete(Long id);

    void delete(WarehouseIssueConsDTO.Delete request);

    TotalResponse<WarehouseIssueConsDTO.Info> search(NICICOCriteria criteria);

    SearchDTO.SearchRs<WarehouseIssueConsDTO.Info> search(SearchDTO.SearchRq request);
}
