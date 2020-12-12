package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.TypicalAssayDTO;

import java.util.List;

public interface ITypicalAssayService {

    TypicalAssayDTO.Info get(Long id);

    List<TypicalAssayDTO.Info> list();

    TypicalAssayDTO.Info create(TypicalAssayDTO.Create request);

    TypicalAssayDTO.Info update(Long id, TypicalAssayDTO.Update request);

    void delete(Long id);

    void deleteAll(TypicalAssayDTO.Delete request);

    TotalResponse<TypicalAssayDTO.Info> search(NICICOCriteria criteria);

}
