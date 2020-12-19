package com.nicico.sales.iservice;

import com.nicico.sales.dto.RemittanceViewDTO;
import com.nicico.sales.model.entities.warehouse.RemittanceView;

import java.util.List;

public interface IRemittanceViewService extends IGenericService<RemittanceView, Long, RemittanceViewDTO.Create, RemittanceViewDTO.Info, RemittanceViewDTO.Update, RemittanceViewDTO.Delete> {



}
