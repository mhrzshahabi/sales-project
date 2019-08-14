package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentMoistureHeaderDTO;

import java.util.List;

public interface IShipmentMoistureHeaderService {

	ShipmentMoistureHeaderDTO.Info get(Long id);

	List<ShipmentMoistureHeaderDTO.Info> list();

	ShipmentMoistureHeaderDTO.Info create(ShipmentMoistureHeaderDTO.Create request);

	ShipmentMoistureHeaderDTO.Info update(Long id, ShipmentMoistureHeaderDTO.Update request);

	void delete(Long id);

	void delete(ShipmentMoistureHeaderDTO.Delete request);

	SearchDTO.SearchRs<ShipmentMoistureHeaderDTO.Info> search(SearchDTO.SearchRq request);
}