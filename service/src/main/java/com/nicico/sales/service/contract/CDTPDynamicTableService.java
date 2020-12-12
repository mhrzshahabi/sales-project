package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.CDTPDynamicTableDTO;
import com.nicico.sales.iservice.contract.ICDTPDynamicTableService;
import com.nicico.sales.model.entities.contract.CDTPDynamicTable;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CDTPDynamicTableService extends GenericService<CDTPDynamicTable, Long, CDTPDynamicTableDTO.Create, CDTPDynamicTableDTO.Info, CDTPDynamicTableDTO.Update, CDTPDynamicTableDTO.Delete> implements ICDTPDynamicTableService {
}
