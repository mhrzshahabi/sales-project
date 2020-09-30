package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDiscountDTO;

import java.util.List;

public interface IContractDiscountService {

	List<ContractDiscountDTO.Info> list();

	TotalResponse<ContractDiscountDTO.Info> search(NICICOCriteria request);

	ContractDiscountDTO getByCuPercent(Double percent);

	ContractDiscountDTO.Info get(Long id);

	ContractDiscountDTO.Info create(ContractDiscountDTO.Create request);

	ContractDiscountDTO.Info update(Long id, ContractDiscountDTO.Update request);

    void delete(Long id);

	void deleteAll(ContractDiscountDTO.Delete request);
}
