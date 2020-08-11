package com.nicico.sales.service.warehouse;

import com.google.common.primitives.Longs;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.warehous.IWarehouseService;
import com.nicico.sales.model.entities.warehouse.Warehouse;
import com.nicico.sales.repository.warehouse.WarehouseDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
public class WarehouseService implements IWarehouseService {
    private final WarehouseDAO warehouseDAO;
    private final ModelMapper modelMapper;
    private final JdbcTemplate jdbcTemplate;

    @Override
    public WarehouseDTO.Info get(Long id) {
        final Optional<Warehouse> one = warehouseDAO.findById(id);
        final Warehouse warehouse = one.orElseThrow(() -> new NotFoundException());
        return modelMapper.map(warehouse, WarehouseDTO.Info.class);
    }

    @Override
    public List<WarehouseDTO.Info> list() {
        return modelMapper.map(warehouseDAO.findAll(), new TypeToken<List<WarehouseDTO.Info>>() {
        }.getType());
    }

    @Override
    public TotalResponse<WarehouseDTO.Info> search(NICICOCriteria request) {
        final TotalResponse<WarehouseDTO.Info> response = SearchUtil.search(warehouseDAO, request, entity -> modelMapper.map(entity, WarehouseDTO.Info.class));
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
        final List<Warehouse> plantIdUpdate = new ArrayList<>();
        final List<Long> sarcheshmeh = Longs.asList(2673, 2675, 1000, 1166, 1181, 1560, 1580, 2502, 2503);
        final List<Long> doshtoron = Longs.asList(1021, 1022, 1240, 1980);
        final List<Long> miduk = Longs.asList(2565, 2583, 1540, 1820, 2477);
        final List<Long> songun = Longs.asList(2535, 2635, 1185, 1541, 1721, 2421, 2495);
        final List<Long> bandar = Longs.asList(2585L, 2594L, 2609L, 2611L, 2621L, 2631L, 3645L,
                2649L, 2653L, 2661L, 2665L, 2666L, 2669L, 2670L,
                2671L, 2677L, 2679L, 2681L, 2683L, 2685L, 2555L,
                1020L, 1581L, 1582L, 1880L, 2320L, 2340L, 2360, 2627,2645);
        final List<Warehouse> sarcheshmehia = warehouseDAO.getAllByPlantIdIsNullAndIdIn(sarcheshmeh);
        final List<Warehouse> bandaria = warehouseDAO.getAllByPlantIdIsNullAndIdIn(bandar);
        final List<Warehouse> doshtoronia = warehouseDAO.getAllByPlantIdIsNullAndIdIn(doshtoron);
        final List<Warehouse> midukia = warehouseDAO.getAllByPlantIdIsNullAndIdIn(miduk);
        final List<Warehouse> songunia = warehouseDAO.getAllByPlantIdIsNullAndIdIn(songun);
        sarcheshmehia.stream().forEach(b->b.setPlantId(1L));
        doshtoronia.stream().forEach(b->b.setPlantId(2L));
        bandaria.stream().forEach(b->b.setPlantId(3L));
        midukia.stream().forEach(b->b.setPlantId(4L));
        songunia.stream().forEach(b->b.setPlantId(5L));
        plantIdUpdate.addAll(Stream.of(bandaria,sarcheshmehia,doshtoronia,midukia,songunia).flatMap(w->w.stream()).collect(Collectors.toList()));
        warehouseDAO.saveAll(plantIdUpdate);
    }

}
