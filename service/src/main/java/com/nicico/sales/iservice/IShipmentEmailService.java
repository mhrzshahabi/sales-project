package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ShipmentEmailDTO;

import javax.mail.MessagingException;
import java.util.List;

public interface IShipmentEmailService {

    ShipmentEmailDTO.Info get(Long id);

    List<ShipmentEmailDTO.Info> list();

    ShipmentEmailDTO.Info create(ShipmentEmailDTO.Create request) throws MessagingException;

    ShipmentEmailDTO.Info update(Long id, ShipmentEmailDTO.Update request);

    void delete(Long id);

    void delete(ShipmentEmailDTO.Delete request);

    TotalResponse<ShipmentEmailDTO.Info> search(NICICOCriteria criteria);
}
