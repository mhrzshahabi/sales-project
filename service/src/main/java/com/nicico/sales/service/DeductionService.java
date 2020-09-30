package com.nicico.sales.service;


import com.nicico.sales.dto.DeductionDTO;
import com.nicico.sales.iservice.IDeductionService;
import com.nicico.sales.model.entities.base.Deduction;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DeductionService extends GenericService<Deduction, Long, DeductionDTO.Create, DeductionDTO.Info, DeductionDTO.Update, DeductionDTO.Delete> implements IDeductionService {
}
