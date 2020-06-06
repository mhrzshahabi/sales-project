package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentTypeDTO;

import java.util.List;

public interface IShipmentTypeService {

    ShipmentTypeDTO.Info get(Long id);

    List<ShipmentTypeDTO.Info> list();

    ShipmentTypeDTO.Info create(ShipmentTypeDTO.Create request);

    ShipmentTypeDTO.Info update(Long id, ShipmentTypeDTO.Update request);

    void delete(Long id);

    void deleteAll(ShipmentTypeDTO.Delete request);

    TotalResponse<ShipmentTypeDTO.Info> search(NICICOCriteria criteria);

}
