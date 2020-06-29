package com.nicico.sales.service;

import com.nicico.sales.dto.MaterialElementDTO;
import com.nicico.sales.iservice.IMaterialElementService;
import com.nicico.sales.model.entities.warehouse.MaterialElement;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MaterialElementService extends GenericService<MaterialElement, Long, MaterialElementDTO.Create, MaterialElementDTO.Info, MaterialElementDTO.Update, MaterialElementDTO.Delete> implements IMaterialElementService {

}
