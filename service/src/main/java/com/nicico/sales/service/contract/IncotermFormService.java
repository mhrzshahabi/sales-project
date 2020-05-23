package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.IncotermFormDTO;
import com.nicico.sales.iservice.contract.IIncotermFormService;
import com.nicico.sales.model.entities.contract.IncotermForm;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class IncotermFormService extends GenericService<IncotermForm, Long, IncotermFormDTO.Create, IncotermFormDTO.Info, IncotermFormDTO.Update, IncotermFormDTO.Delete> implements IIncotermFormService {
}
