package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ShipmentDTO;
import com.nicico.sales.model.entities.base.Shipment;

import java.util.List;

public interface IShipmentService extends IGenericService<Shipment, Long, ShipmentDTO.Create, ShipmentDTO.Info, ShipmentDTO.Update, ShipmentDTO.Delete> {

    List<Object[]> pickListShipment();

    TotalResponse<ShipmentDTO.ShipmentLightFIInfo> foreignSearch(NICICOCriteria request);

    SearchDTO.SearchRs<ShipmentDTO.ShipmentLightFIInfo> foreignSearch(SearchDTO.SearchRq request);

    TotalResponse<ShipmentDTO.ReportInfo> reportSearch(NICICOCriteria nicicoCriteria);

    SearchDTO.SearchRs<ShipmentDTO.ReportInfo> reportSearch(SearchDTO.SearchRq request);
}
