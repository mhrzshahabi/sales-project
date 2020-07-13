package com.nicico.sales.iservice;



import com.nicico.sales.dto.PortDTO;
import com.nicico.sales.model.entities.base.Port;


public interface IPortService extends IGenericService<Port, Long , PortDTO.Create , PortDTO.Info , PortDTO.Update , PortDTO.Delete> {

}