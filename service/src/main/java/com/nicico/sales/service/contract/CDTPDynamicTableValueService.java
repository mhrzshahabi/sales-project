package com.nicico.sales.service.contract;

import com.nicico.sales.dto.CDTPDynamicTableValueDTO;
import com.nicico.sales.iservice.ICDTPDynamicTableValueService;
import com.nicico.sales.model.entities.contract.CDTPDynamicTableValue;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CDTPDynamicTableValueService extends GenericService<CDTPDynamicTableValue, Long, CDTPDynamicTableValueDTO.Create, CDTPDynamicTableValueDTO.Info, CDTPDynamicTableValueDTO.Update, CDTPDynamicTableValueDTO.Delete> implements ICDTPDynamicTableValueService {
}