package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentEmailDTO;

import java.util.List;

public interface IShipmentEmailService {

	ShipmentEmailDTO.Info get(Long id);

	List<ShipmentEmailDTO.Info> list();

	ShipmentEmailDTO.Info create(ShipmentEmailDTO.Create request);

	ShipmentEmailDTO.Info update(Long id, ShipmentEmailDTO.Update request);

	void delete(Long id);

	void delete(ShipmentEmailDTO.Delete request);

	SearchDTO.SearchRs<ShipmentEmailDTO.Info> search(SearchDTO.SearchRq request);
}
