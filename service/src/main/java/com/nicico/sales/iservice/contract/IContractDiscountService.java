package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDiscountDto;
import java.util.List;

public interface IContractDiscountService {

    List<ContractDiscountDto> list();

    TotalResponse<ContractDiscountDto> search(NICICOCriteria request);

    ContractDiscountDto getByCuPercent(Double percent);
}