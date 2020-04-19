package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PaymentTypeDTO;
import com.nicico.sales.dto.PercentPerYearDTO;

import java.util.List;

public interface IPercentPerYearService {

    List<PercentPerYearDTO.Info> list();

    TotalResponse<PercentPerYearDTO.Info> search(NICICOCriteria criteria);
}
