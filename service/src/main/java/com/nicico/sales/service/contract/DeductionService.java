package com.nicico.sales.service.contract;


import com.nicico.sales.dto.contract.DeductionDTO;
import com.nicico.sales.iservice.contract.IDeductionService;
import com.nicico.sales.model.entities.contract.Deduction;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DeductionService extends GenericService<Deduction, Long, DeductionDTO.Create, DeductionDTO.Info, DeductionDTO.Update, DeductionDTO.Delete> implements IDeductionService {
}
