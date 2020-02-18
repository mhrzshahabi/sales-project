package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ParametersDTO;

import java.util.List;

public interface IParametersService {

    ParametersDTO.Info get(Long id);

    List<ParametersDTO.Info> list();

    ParametersDTO.Info create(ParametersDTO.Create request);

    ParametersDTO.Info update(Long id, ParametersDTO.Update request);

    void delete(Long id);

    void delete(ParametersDTO.Delete request);

    TotalResponse<ParametersDTO.Info> search(NICICOCriteria criteria);
}
