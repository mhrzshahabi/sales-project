package com.nicico.sales.service;

import com.nicico.sales.dto.ElementDTO;
import com.nicico.sales.iservice.IElementService;
import com.nicico.sales.model.entities.warehouse.Element;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ElementService extends GenericService<Element, Long, ElementDTO.Create, ElementDTO.Info, ElementDTO.Update, ElementDTO.Delete> implements IElementService {

}
