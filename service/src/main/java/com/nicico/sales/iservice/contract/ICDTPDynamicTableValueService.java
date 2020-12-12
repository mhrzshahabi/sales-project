package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.CDTPDynamicTableValueDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.CDTPDynamicTableValue;

public interface ICDTPDynamicTableValueService extends IGenericService<CDTPDynamicTableValue, Long, CDTPDynamicTableValueDTO.Create, CDTPDynamicTableValueDTO.Info, CDTPDynamicTableValueDTO.Update, CDTPDynamicTableValueDTO.Delete> {
}
