package com.nicico.sales.service;

import com.nicico.sales.dto.InventoryDTO;
import com.nicico.sales.iservice.IinventoryService;
import com.nicico.sales.model.entities.warehouse.Inventory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class InventoryService extends GenericService<Inventory, Long, InventoryDTO.Create, InventoryDTO.Info, InventoryDTO.Update, InventoryDTO.Delete> implements IinventoryService {

}
