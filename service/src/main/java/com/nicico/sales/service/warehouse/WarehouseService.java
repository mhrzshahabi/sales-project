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
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

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
    @Transactional
    public void updateFromTozinView() {
        List<Object[]> allWarehousesFromViewForUpdate = warehouseDAO.getFromViewForUpdate();
        Map<Long, String> warehousesFetchedForUpdate = new HashMap<>();
        allWarehousesFromViewForUpdate.stream()
                .forEach((Object[] u) -> warehousesFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<Warehouse> warehouseListForUpdate = warehouseDAO.findAllById(warehousesFetchedForUpdate.keySet());
        warehouseListForUpdate.stream()
                .forEach(u -> u.setName(warehousesFetchedForUpdate.get(u.getId())));
        List<Object[]> allWarehousesFromViewForInsert = warehouseDAO.getFromViewForInsert();
        warehouseListForUpdate.addAll(allWarehousesFromViewForInsert
                .stream()
                .map(u -> new Warehouse()
                        .setId(Long.valueOf(u[0].toString()))
                        .setName(u[1].toString()))
                .collect(Collectors.toList()));
        warehouseDAO.saveAll(warehouseListForUpdate);
    }

}
