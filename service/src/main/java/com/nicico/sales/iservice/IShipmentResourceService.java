package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentResourceDTO;

import java.util.List;

public interface IShipmentResourceService {

	ShipmentResourceDTO.Info get(Long id);

	List<ShipmentResourceDTO.Info> list();

	ShipmentResourceDTO.Info create(ShipmentResourceDTO.Create request);

	ShipmentResourceDTO.Info update(Long id, ShipmentResourceDTO.Update request);

	void delete(Long id);

	void delete(ShipmentResourceDTO.Delete request);

	SearchDTO.SearchRs<ShipmentResourceDTO.Info> search(SearchDTO.SearchRq request);
}
