package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.DeductionDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.Deduction;

public interface IDeductionService extends IGenericService<Deduction, Long, DeductionDTO.Create, DeductionDTO.Info, DeductionDTO.Update, DeductionDTO.Delete> {
}
