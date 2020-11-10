package com.nicico.sales.service.warehouse;

import com.nicico.sales.dto.PackingListDTO;
import com.nicico.sales.iservice.contract.IPackingListService;
import com.nicico.sales.model.entities.warehouse.PackingList;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PackingListService extends GenericService<PackingList, Long, PackingListDTO.Create, PackingListDTO.Info, PackingListDTO.Update, PackingListDTO.Delete> implements IPackingListService {
}
