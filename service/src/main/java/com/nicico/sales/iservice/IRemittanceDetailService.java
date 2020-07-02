package com.nicico.sales.iservice;

import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;

import java.util.List;

public interface IRemittanceDetailService extends IGenericService<RemittanceDetail, Long, RemittanceDetailDTO.Create, RemittanceDetailDTO.Info, RemittanceDetailDTO.Update, RemittanceDetailDTO.Delete> {
    List<RemittanceDetailDTO.Info> batchUpdate(RemittanceDetailDTO.WithRemittanceAndInventory request);
}
