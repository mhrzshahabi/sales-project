package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentDTO;

import java.util.List;

public interface IShipmentService {

	ShipmentDTO.Info get(Long id);

	List<ShipmentDTO.Info> list();

	ShipmentDTO.Info create(ShipmentDTO.Create request);

	ShipmentDTO.Info update(Long id, ShipmentDTO.Update request);

	void delete(Long id);

	void delete(ShipmentDTO.Delete request);

	SearchDTO.SearchRs<ShipmentDTO.Info> search(SearchDTO.SearchRq request);

	List<Object[]> pickListShipment();

	List<String> findLotname(String id ); //Add by jalal

}
