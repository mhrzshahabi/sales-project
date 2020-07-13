package com.nicico.sales.service;


import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.iservice.IUnitService;
import com.nicico.sales.model.entities.base.Unit;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class UnitService extends GenericService<Unit, Long, UnitDTO.Create, UnitDTO.Info, UnitDTO.Update, UnitDTO.Delete> implements IUnitService {

}