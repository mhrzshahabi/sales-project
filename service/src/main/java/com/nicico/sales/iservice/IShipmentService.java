package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.model.entities.base.Shipment;

import java.util.List;

public interface IShipmentService extends IGenericService<Shipment, Long, ShipmentDTO.Create, ShipmentDTO.Info, ShipmentDTO.Update, ShipmentDTO.Delete> {

    List<Object[]> pickListShipment();

    TotalResponse<ShipmentDTO.ReportInfo> reportSearch(NICICOCriteria nicicoCriteria);

}
