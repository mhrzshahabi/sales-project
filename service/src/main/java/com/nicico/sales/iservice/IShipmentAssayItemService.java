package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentAssayItemDTO;

import java.util.List;

public interface IShipmentAssayItemService {

	ShipmentAssayItemDTO.Info get(Long id);

	List<ShipmentAssayItemDTO.Info> list();

	ShipmentAssayItemDTO.Info create(ShipmentAssayItemDTO.Create request);

	ShipmentAssayItemDTO.Info update(Long id, ShipmentAssayItemDTO.Update request);

	void delete(Long id);

	void delete(ShipmentAssayItemDTO.Delete request);

	SearchDTO.SearchRs<ShipmentAssayItemDTO.Info> search(SearchDTO.SearchRq request);
}
