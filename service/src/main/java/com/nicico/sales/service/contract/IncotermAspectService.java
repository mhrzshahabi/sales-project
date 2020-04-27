package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermAspectDTO;
import com.nicico.sales.iservice.contract.IIncotermAspectService;
import com.nicico.sales.model.entities.contract.IncotermAspect;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermAspectService extends GenericService<IncotermAspect, Long, IncotermAspectDTO.Create, IncotermAspectDTO.Info, IncotermAspectDTO.Update, IncotermAspectDTO.Delete> implements IIncotermAspectService {
}