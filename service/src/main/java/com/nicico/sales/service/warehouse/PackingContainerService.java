package com.nicico.sales.service.warehouse;

import com.nicico.sales.dto.PackingContainerDTO;
import com.nicico.sales.iservice.contract.IPackingContainerService;
import com.nicico.sales.model.entities.warehouse.PackingContainer;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PackingContainerService extends GenericService<PackingContainer, Long, PackingContainerDTO.Create, PackingContainerDTO.Info, PackingContainerDTO.Update, PackingContainerDTO.Delete> implements IPackingContainerService {
}
