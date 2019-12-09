package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentHeaderDTO;

import java.util.List;

public interface IShipmentHeaderService {

	ShipmentHeaderDTO.Info get(Long id);

	List<ShipmentHeaderDTO.Info> list();

	ShipmentHeaderDTO.Info create(ShipmentHeaderDTO.Create request);

	ShipmentHeaderDTO.Info update(Long id, ShipmentHeaderDTO.Update request);

	void delete(Long id);

	void delete(ShipmentHeaderDTO.Delete request);

	TotalResponse<ShipmentHeaderDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<ShipmentHeaderDTO.Info> search(SearchDTO.SearchRq request);
}
