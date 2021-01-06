package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.ContractDiscountDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractDiscount;

public interface IContractDiscountService extends IGenericService<ContractDiscount, Long, ContractDiscountDTO.Create, ContractDiscountDTO.Info, ContractDiscountDTO.Update, ContractDiscountDTO.Delete> {

    ContractDiscountDTO getByCuPercent(Double percent);
}
