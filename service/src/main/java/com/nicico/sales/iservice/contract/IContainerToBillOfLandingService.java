package com.nicico.sales.iservice.contract;


import com.nicico.sales.dto.contract.ContainerToBillOfLandingDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContainerToBillOfLanding;

public interface IContainerToBillOfLandingService extends IGenericService<ContainerToBillOfLanding, Long, ContainerToBillOfLandingDTO.Create, ContainerToBillOfLandingDTO.Info, ContainerToBillOfLandingDTO.Update, ContainerToBillOfLandingDTO.Delete> {

}
