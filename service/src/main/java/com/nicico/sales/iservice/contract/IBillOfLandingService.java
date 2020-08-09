package com.nicico.sales.iservice.contract;


import com.nicico.sales.dto.contract.BillOfLandingDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.BillOfLanding;

public interface IBillOfLandingService extends IGenericService<BillOfLanding, Long, BillOfLandingDTO.Create, BillOfLandingDTO.Info, BillOfLandingDTO.Update, BillOfLandingDTO.Delete> {

}
