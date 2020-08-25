package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.WarehouseStockDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IWarehouseStockService;
import com.nicico.sales.model.entities.base.WarehouseStock;
import com.nicico.sales.repository.WarehouseStockDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class WarehouseStockService extends GenericService<WarehouseStock, Long, WarehouseStockDTO.Create, WarehouseStockDTO.Info, WarehouseStockDTO.Update, WarehouseStockDTO.Delete> implements IWarehouseStockService {

    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.List)
    public List<Object[]> warehouseStockConc() {
        return ((WarehouseStockDAO) repository).warehouseStockConc();
    }
}
