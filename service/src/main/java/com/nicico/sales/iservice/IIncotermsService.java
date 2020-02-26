package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.IncotermsDTO;

import java.util.List;

public interface IIncotermsService {

    IncotermsDTO.Info get(Long id);

    List<IncotermsDTO.Info> list();

    IncotermsDTO.Info create(IncotermsDTO.Create request);

    IncotermsDTO.Info update(Long id, IncotermsDTO.Update request);

    void delete(Long id);

    void delete(IncotermsDTO.Delete request);

    TotalResponse<IncotermsDTO.Info> search(NICICOCriteria criteria);
}
