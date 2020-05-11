package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccDepartmentDTO;

public interface IAccDepartmentService {

    TotalResponse<AccDepartmentDTO.Info> search(NICICOCriteria criteria);
}
