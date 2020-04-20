package com.nicico.sales.service.base2;

import com.nicico.sales.dto.base2.UnitDTO;
import com.nicico.sales.iservice.base2.IUnitService;
import com.nicico.sales.model.entities.base2.Unit;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class UnitService extends GenericService<Unit, Long, UnitDTO.Create, UnitDTO.Info, UnitDTO.Update, UnitDTO.Delete> implements IUnitService {

}
