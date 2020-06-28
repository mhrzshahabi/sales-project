package com.nicico.sales.iservice;

import com.nicico.sales.dto.RemittanceDTO;
import com.nicico.sales.model.entities.warehouse.Remittance;

public interface IRemittanceService extends IGenericService<Remittance, Long, RemittanceDTO.Create, RemittanceDTO.Info, RemittanceDTO.Update, RemittanceDTO.Delete> {

}
