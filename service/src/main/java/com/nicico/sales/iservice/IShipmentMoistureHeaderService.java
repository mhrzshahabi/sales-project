package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentMoistureHeaderDTO;

import java.util.List;

public interface IShipmentMoistureHeaderService {

    ShipmentMoistureHeaderDTO.Info get(Long id);

    List<ShipmentMoistureHeaderDTO.Info> list();

    ShipmentMoistureHeaderDTO.Info create(ShipmentMoistureHeaderDTO.Create request);

    ShipmentMoistureHeaderDTO.Info update(Long id, ShipmentMoistureHeaderDTO.Update request);

    void delete(Long id);

    void delete(ShipmentMoistureHeaderDTO.Delete request);

    TotalResponse<ShipmentMoistureHeaderDTO.Info> search(NICICOCriteria criteria);
}
