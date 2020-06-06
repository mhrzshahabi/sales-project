package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AnalysisMoDTO;


import java.util.List;

public interface IAnalysisMoService {

    AnalysisMoDTO.Info get(Long id);

    List<AnalysisMoDTO.Info> list();

    AnalysisMoDTO.Info create(AnalysisMoDTO.Create request);

    AnalysisMoDTO.Info update(Long id, AnalysisMoDTO.Update request);

    void delete(Long id);

    void deleteAll(AnalysisMoDTO.Delete request);

    TotalResponse<AnalysisMoDTO.Info> search(NICICOCriteria criteria);

}
