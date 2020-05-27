package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentMethodDTO;

import java.util.List;


public interface IShipmentMethodService {

    ShipmentMethodDTO.Info get(Long id);

    List<ShipmentMethodDTO.Info> list();

    ShipmentMethodDTO.Info create(ShipmentMethodDTO.Create request);

    ShipmentMethodDTO.Info update(Long id, ShipmentMethodDTO.Update request);

    void delete(Long id);

    void deleteAll(ShipmentMethodDTO.Delete request);

    TotalResponse<ShipmentMethodDTO.Info> search(NICICOCriteria criteria);
}
