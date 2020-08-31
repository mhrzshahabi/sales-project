package com.nicico.sales.service;

import com.nicico.sales.dto.DCCDTO;
import com.nicico.sales.iservice.IDCCService;
import com.nicico.sales.iservice.IShipmentDCCService;
import com.nicico.sales.model.entities.base.DCC;
import com.nicico.sales.repository.DCCDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class ShipmentDCCService extends GenericService<DCC, Long, DCCDTO.Create, DCCDTO.Info, DCCDTO.Update, DCCDTO.Delete> implements IShipmentDCCService {
    public Long findNextImageNumber() {
        return ((DCCDAO) repository).findNextImageNumber();
    }
}
