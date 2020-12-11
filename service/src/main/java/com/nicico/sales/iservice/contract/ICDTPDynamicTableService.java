package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.CDTPDynamicTableDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.CDTPDynamicTable;

public interface ICDTPDynamicTableService extends IGenericService<CDTPDynamicTable, Long, CDTPDynamicTableDTO.Create, CDTPDynamicTableDTO.Info, CDTPDynamicTableDTO.Update, CDTPDynamicTableDTO.Delete> {
}
