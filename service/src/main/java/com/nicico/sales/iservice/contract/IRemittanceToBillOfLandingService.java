package com.nicico.sales.iservice.contract;


import com.nicico.sales.dto.contract.RemittanceToBillOfLandingDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.RemittanceToBillOfLanding;

import java.util.List;

public interface IRemittanceToBillOfLandingService extends IGenericService<RemittanceToBillOfLanding, Long,
        RemittanceToBillOfLandingDTO.Create, RemittanceToBillOfLandingDTO.Info,
        RemittanceToBillOfLandingDTO.Update, RemittanceToBillOfLandingDTO.Delete> {
    List<RemittanceToBillOfLandingDTO.Info> batch(List<RemittanceToBillOfLandingDTO.Create> request);
}
