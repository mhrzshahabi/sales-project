package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.WarehouseIssueCathodeDTO;

import java.util.List;

public interface IWarehouseIssueCathodeService {

	WarehouseIssueCathodeDTO.Info get(Long id);

	List<WarehouseIssueCathodeDTO.Info> list();

	WarehouseIssueCathodeDTO.Info create(WarehouseIssueCathodeDTO.Create request);

	WarehouseIssueCathodeDTO.Info update(Long id, WarehouseIssueCathodeDTO.Update request);

	void delete(Long id);

	void delete(WarehouseIssueCathodeDTO.Delete request);

	TotalResponse<WarehouseIssueCathodeDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<WarehouseIssueCathodeDTO.Info> search(SearchDTO.SearchRq request);
}
