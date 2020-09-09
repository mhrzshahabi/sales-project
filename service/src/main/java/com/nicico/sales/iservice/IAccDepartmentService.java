package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccountingDepartmentDTO;

public interface IAccDepartmentService {

    TotalResponse<AccountingDepartmentDTO.Info> search(NICICOCriteria criteria);
}
