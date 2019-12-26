package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentAssayItemDTO;

import java.util.List;

public interface IShipmentAssayItemService {

	ShipmentAssayItemDTO.Info get(Long id);

	List<ShipmentAssayItemDTO.Info> list();

	ShipmentAssayItemDTO.Info create(ShipmentAssayItemDTO.Create request);

	ShipmentAssayItemDTO.Info update(Long id, ShipmentAssayItemDTO.Update request);

	void delete(Long id);

	void delete(ShipmentAssayItemDTO.Delete request);

	TotalResponse<ShipmentAssayItemDTO.Info> search(NICICOCriteria criteria);

	String createAddAssayPaste(String data);
}
