package com.nicico.sales.iservice;

import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;

public interface IRemittanceDetailService extends IGenericService<RemittanceDetail, Long, RemittanceDetailDTO.Create, RemittanceDetailDTO.Info, RemittanceDetailDTO.Update, RemittanceDetailDTO.Delete> {

}
