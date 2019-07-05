package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentMoistureItemDTO;

import java.util.List;

public interface IShipmentMoistureItemService {

	ShipmentMoistureItemDTO.Info get(Long id);

	List<ShipmentMoistureItemDTO.Info> list();

	ShipmentMoistureItemDTO.Info create(ShipmentMoistureItemDTO.Create request);

	ShipmentMoistureItemDTO.Info update(Long id, ShipmentMoistureItemDTO.Update request);

	void delete(Long id);

	void delete(ShipmentMoistureItemDTO.Delete request);

	SearchDTO.SearchRs<ShipmentMoistureItemDTO.Info> search(SearchDTO.SearchRq request);
}
