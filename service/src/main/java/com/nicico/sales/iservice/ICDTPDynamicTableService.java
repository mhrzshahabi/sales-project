package com.nicico.sales.iservice;


import com.nicico.sales.dto.CDTPDynamicTableDTO;
import com.nicico.sales.model.entities.contract.CDTPDynamicTable;

public interface ICDTPDynamicTableService extends IGenericService<CDTPDynamicTable, Long, CDTPDynamicTableDTO.Create, CDTPDynamicTableDTO.Info, CDTPDynamicTableDTO.Update, CDTPDynamicTableDTO.Delete> {
}
