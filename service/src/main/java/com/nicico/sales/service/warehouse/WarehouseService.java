package com.nicico.sales.service.warehouse;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.WarehouseDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.warehous.IWarehouseService;
import com.nicico.sales.model.entities.warehouse.Warehouse;
import com.nicico.sales.repository.warehouse.WarehouseDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
public class WarehouseService extends GenericService<Warehouse, Long, WarehouseDTO, WarehouseDTO.Info, WarehouseDTO, WarehouseDTO> implements IWarehouseService {

    @Action(value = ActionType.UpdateAll)
    @Transactional
    @Override
    public void updateFromTozinView() {
        List<Object[]> allItemsFromViewForUpdate = ((WarehouseDAO)repository).getAllWarehousesFromViewForUpdate();
        Map<Long, String> ItemsFetchedForUpdate = new HashMap<>();
        allItemsFromViewForUpdate.stream()
                .forEach((Object[] u) -> ItemsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<Warehouse> warehouses = new ArrayList<>();
        warehouses.addAll(((WarehouseDAO)repository).findAllById(ItemsFetchedForUpdate.keySet()));
        warehouses.stream()
                .forEach(u -> u.setName(ItemsFetchedForUpdate.get(u.getId())));
        List<Object[]> allItemsFromViewForInsert = ((WarehouseDAO)repository).getAllWarehousesFromViewForInsert();
        Stream<Warehouse> warehouseStream = allItemsFromViewForInsert
                .stream()
                .map(u -> new Warehouse()
                        .setId(Long.valueOf(u[0].toString()))
                        .setName(u[1].toString())
                );
        List<Warehouse> collect = warehouseStream
                .collect(Collectors.toList());
        warehouses.addAll(collect);
        ((WarehouseDAO)repository).saveAll(warehouses);
    }

}
