package com.nicico.sales.service;

import com.nicico.sales.dto.ParametersDTO;
import com.nicico.sales.iservice.IParametersService;
import com.nicico.sales.model.entities.base.Parameters;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class ParametersService extends GenericService<Parameters, Long, ParametersDTO.Create, ParametersDTO.Info, ParametersDTO.Update, ParametersDTO.Delete> implements IParametersService {
}
