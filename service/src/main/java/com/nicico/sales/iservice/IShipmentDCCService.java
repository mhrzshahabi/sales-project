package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.DCCDTO;
import com.nicico.sales.model.entities.base.DCC;

import java.util.List;

public interface IShipmentDCCService {

    DCCDTO.Info get(Long id);

    List<DCCDTO.Info> list();

    DCCDTO.Info create(DCCDTO.Create request);

    DCCDTO.Info update(Long id, DCCDTO.Update request);

    void delete(Long id);

    void deleteAll(DCCDTO.Delete request);

    TotalResponse<DCCDTO.Info> search(NICICOCriteria criteria);

    Long findNextImageNumber();

    DCC getByFileNewName(String fileNewName);
}
