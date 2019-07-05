package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentPriceDTO;

import java.util.List;

public interface IShipmentPriceService {

	ShipmentPriceDTO.Info get(Long id);

	List<ShipmentPriceDTO.Info> list();

	ShipmentPriceDTO.Info create(ShipmentPriceDTO.Create request);

	ShipmentPriceDTO.Info update(Long id, ShipmentPriceDTO.Update request);

	void delete(Long id);

	void delete(ShipmentPriceDTO.Delete request);

	SearchDTO.SearchRs<ShipmentPriceDTO.Info> search(SearchDTO.SearchRq request);
}
