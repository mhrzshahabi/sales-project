package com.nicico.sales.service;

import com.nicico.sales.dto.CDTPDynamicTableValueDTO;
import com.nicico.sales.iservice.ICDTPDynamicTableValueService;
import com.nicico.sales.model.entities.contract.CDTPDynamicTableValue;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class CDTPDynamicTableValueService extends GenericService<CDTPDynamicTableValue, Long, CDTPDynamicTableValueDTO.Create,
        CDTPDynamicTableValueDTO.Info, CDTPDynamicTableValueDTO.Update, CDTPDynamicTableValueDTO.Delete>
        implements ICDTPDynamicTableValueService {
}
