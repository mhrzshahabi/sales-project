package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermStepDTO;
import com.nicico.sales.iservice.contract.IIncotermStepService;
import com.nicico.sales.model.entities.contract.IncotermStep;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermStepService extends GenericService<IncotermStep, Long, IncotermStepDTO.Create, IncotermStepDTO.Info, IncotermStepDTO.Update, IncotermStepDTO.Delete> implements IIncotermStepService {
}