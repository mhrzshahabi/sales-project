package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentMoistureItemDTO;

import java.util.List;

public interface IShipmentMoistureItemService {

	ShipmentMoistureItemDTO.Info get(Long id);

	List<ShipmentMoistureItemDTO.Info> list();

	ShipmentMoistureItemDTO.Info create(ShipmentMoistureItemDTO.Create request);

	ShipmentMoistureItemDTO.Info update(Long id, ShipmentMoistureItemDTO.Update request);

	void delete(Long id);

	void delete(ShipmentMoistureItemDTO.Delete request);

	TotalResponse<ShipmentMoistureItemDTO.Info> search(NICICOCriteria criteria);

	String createAddMoisturePaste(String data);
}
