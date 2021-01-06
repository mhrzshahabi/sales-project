package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.TypicalAssayDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.TypicalAssay;

public interface ITypicalAssayService extends IGenericService<TypicalAssay, Long, TypicalAssayDTO.Create, TypicalAssayDTO.Info, TypicalAssayDTO.Update, TypicalAssayDTO.Delete> {
}
