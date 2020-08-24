package com.nicico.sales.service.warehouse;

import com.nicico.sales.dto.DepotDTO;
import com.nicico.sales.iservice.warehous.IDepotService;
import com.nicico.sales.model.entities.warehouse.Depot;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DepotService extends GenericService<Depot, Long, DepotDTO, DepotDTO.Info, DepotDTO, DepotDTO> implements IDepotService {
}
