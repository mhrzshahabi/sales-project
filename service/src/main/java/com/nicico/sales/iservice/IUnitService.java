package com.nicico.sales.iservice;


import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.model.entities.base.Unit;
import org.springframework.stereotype.Repository;

@Repository
public interface IUnitService extends IGenericService<Unit, Long , UnitDTO.Create , UnitDTO.Info , UnitDTO.Update , UnitDTO.Delete> {

}
