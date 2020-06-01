package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AnalyseMoDTO;


import java.util.List;

public interface IAnalyseMoService {

    AnalyseMoDTO.Info get(Long id);

    List<AnalyseMoDTO.Info> list();

    AnalyseMoDTO.Info create(AnalyseMoDTO.Create request);

    AnalyseMoDTO.Info update(Long id, AnalyseMoDTO.Update request);

    void delete(Long id);

    void deleteAll(AnalyseMoDTO.Delete request);

    TotalResponse<AnalyseMoDTO.Info> search(NICICOCriteria criteria);

}
