package com.nicico.sales.service;

import com.nicico.sales.dto.SalesTypeDTO;
import com.nicico.sales.iservice.ISalesTypeService;
import com.nicico.sales.model.entities.base.SalesType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class SalesTypeService extends GenericService<SalesType, Long, SalesTypeDTO, SalesTypeDTO.Info, SalesTypeDTO, SalesTypeDTO> implements ISalesTypeService {

}
