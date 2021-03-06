package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.AccountingDTO;

public interface IAccDepartmentService {

    TotalResponse<AccountingDTO.DepartmentInfo> search(NICICOCriteria criteria);
}
