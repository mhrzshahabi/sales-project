package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentAssayHeaderDTO;

import java.util.List;

public interface IShipmentAssayHeaderService {

	ShipmentAssayHeaderDTO.Info get(Long id);

	List<ShipmentAssayHeaderDTO.Info> list();

	ShipmentAssayHeaderDTO.Info create(ShipmentAssayHeaderDTO.Create request);

	ShipmentAssayHeaderDTO.Info update(Long id, ShipmentAssayHeaderDTO.Update request);

	void delete(Long id);

	void delete(ShipmentAssayHeaderDTO.Delete request);

	SearchDTO.SearchRs<ShipmentAssayHeaderDTO.Info> search(SearchDTO.SearchRq request);
}
