package com.nicico.sales.iservice.contract;


import com.nicico.sales.dto.PackingContainerDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.warehouse.PackingContainer;

public interface IPackingContainerService extends IGenericService<PackingContainer, Long, PackingContainerDTO.Create, PackingContainerDTO.Info, PackingContainerDTO.Update, PackingContainerDTO.Delete> {

}
