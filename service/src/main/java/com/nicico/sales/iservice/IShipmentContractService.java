package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentContractDTO;

import java.util.List;

public interface IShipmentContractService {

	ShipmentContractDTO.Info get(Long id);

	List<ShipmentContractDTO.Info> list();

	ShipmentContractDTO.Info create(ShipmentContractDTO.Create request);

	ShipmentContractDTO.Info update(Long id, ShipmentContractDTO.Update request);

	void delete(Long id);

	void delete(ShipmentContractDTO.Delete request);

	TotalResponse<ShipmentContractDTO.Info> search(NICICOCriteria criteria);
}
