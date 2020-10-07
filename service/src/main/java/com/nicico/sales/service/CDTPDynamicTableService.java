package com.nicico.sales.service;

import com.nicico.sales.dto.CDTPDynamicTableDTO;
import com.nicico.sales.iservice.ICDTPDynamicTableService;
import com.nicico.sales.model.entities.contract.CDTPDynamicTable;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class CDTPDynamicTableService extends GenericService<CDTPDynamicTable, Long, CDTPDynamicTableDTO.Create,
        CDTPDynamicTableDTO.Info, CDTPDynamicTableDTO.Update, CDTPDynamicTableDTO.Delete>
        implements ICDTPDynamicTableService {
}
