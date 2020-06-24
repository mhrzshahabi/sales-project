package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermStepsDTO;
import com.nicico.sales.iservice.contract.IIncotermStepsService;
import com.nicico.sales.model.entities.contract.IncotermSteps;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermStepsService extends GenericService<IncotermSteps, Long, IncotermStepsDTO.Create, IncotermStepsDTO.Info, IncotermStepsDTO.Update, IncotermStepsDTO.Delete> implements IIncotermStepsService {

}
