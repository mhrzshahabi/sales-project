package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentDTO;

import java.util.List;

public interface IShipmentService {

	ShipmentDTO.Info get(Long id);

	List<ShipmentDTO.Info> list();

	ShipmentDTO.Info create(ShipmentDTO.Create request);

	ShipmentDTO.Info update(Long id, ShipmentDTO.Update request);

	void delete(Long id);

	void delete(ShipmentDTO.Delete request);

   TotalResponse<ShipmentDTO.Info> search(NICICOCriteria criteria);

   List<Object[]> pickListShipment();

	List<String> findLotname(String id );

	List<String> findbooking(String id);

	List<String> cname();

	List<String> inspector();


}
