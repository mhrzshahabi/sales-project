package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.dto.VesselDTO;

import java.util.List;

public interface IVesselService {

    VesselDTO.Info get(Long id);

    List<VesselDTO.Info> list();

    VesselDTO.Info create(VesselDTO.Create request);

    VesselDTO.Info update(Long id, VesselDTO.Update request);

    void delete(Long id);

    void delete(VesselDTO.Delete request);

    TotalResponse<VesselDTO.Info> search(NICICOCriteria criteria);
}
