package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentCostDutyDTO;

import java.util.List;

public interface IShipmentCostDutyService {

    ShipmentCostDutyDTO.Info get(Long id);

    List<ShipmentCostDutyDTO.Info> list();

    ShipmentCostDutyDTO.Info create(ShipmentCostDutyDTO.Create request);

    ShipmentCostDutyDTO.Info update(Long id, ShipmentCostDutyDTO.Update request);

    void delete(Long id);

    void deleteAll(ShipmentCostDutyDTO.Delete request);

    TotalResponse<ShipmentCostDutyDTO.Info> search(NICICOCriteria criteria);

}
