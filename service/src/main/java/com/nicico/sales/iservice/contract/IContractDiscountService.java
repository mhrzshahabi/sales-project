package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDiscountDto;

import java.util.List;

public interface IContractDiscountService {

    List<ContractDiscountDto.Info> list();

    TotalResponse<ContractDiscountDto.Info> search(NICICOCriteria request);

    ContractDiscountDto getByCuPercent(Double percent);

    ContractDiscountDto.Info get(Long id);

    ContractDiscountDto.Info create(ContractDiscountDto.Create request);

    ContractDiscountDto.Info update(Long id, ContractDiscountDto.Update request);

    void delete(Long id);

    void deleteAll(ContractDiscountDto.Delete request);
}
