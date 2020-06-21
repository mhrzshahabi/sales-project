package com.nicico.sales.service.warehouse;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.warehous.IWarehouseService;
import com.nicico.sales.model.entities.warehouse.Warehouse;
import com.nicico.sales.repository.warehouse.WarehouseDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
public class WarehouseService implements IWarehouseService {
    private final WarehouseDAO warehouseDAO;

    @Override
    public Warehouse get(Long id) {
        final Optional<Warehouse> one = warehouseDAO.findById(id);
        final Warehouse Warehouse = one.orElseThrow(() -> new NotFoundException());
        return Warehouse;
    }

    @Override
    public List<Warehouse> list() {
        return warehouseDAO.findAll();
    }

    @Override
    public TotalResponse<Warehouse> search(NICICOCriteria request) {
        final TotalResponse<Warehouse> response = SearchUtil.search(warehouseDAO, request, entity -> entity);
        return response;
    }

    @Override
    public void updateFromTozinView() {
        List<Object[]> allItemsFromViewForUpdate = warehouseDAO.getAllWarehousesFromViewForUpdate();
        Map<Long, String> ItemsFetchedForUpdate = new HashMap<>();
        allItemsFromViewForUpdate.stream()
                .forEach((Object[] u) -> ItemsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<Warehouse> warehouses = new ArrayList<>();
        warehouses.addAll(warehouseDAO.findAllById(ItemsFetchedForUpdate.keySet()));
        warehouses.stream()
                .forEach(u -> u.setName(ItemsFetchedForUpdate.get(u.getId())));
        List<Object[]> allItemsFromViewForInsert = warehouseDAO.getAllWarehousesFromViewForInsert();
        Stream<Warehouse> warehouseStream = allItemsFromViewForInsert
                .stream()
                .map(u -> new Warehouse()
                        .setId(Long.valueOf(u[0].toString()))
                        .setName(u[1].toString())
                );
        List<Warehouse> collect = warehouseStream
                .collect(Collectors.toList());
        warehouses.addAll(collect);
        warehouseDAO.saveAll(warehouses);
    }

}
