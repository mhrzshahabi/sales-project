package com.nicico.sales.service.warehouse;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.GoodsDTO;
import com.nicico.sales.iservice.warehous.IItemService;
import com.nicico.sales.model.entities.warehouse.Item;
import com.nicico.sales.repository.warehouse.ItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@RequiredArgsConstructor
@Service
public class ItemService implements IItemService {

    private final ItemDAO dao;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public void updateFromTozinView() {
        List<Object[]> allItemsFromViewForUpdate = dao.itemsForUpdate();
        Map<Long, String> itemsFetchedForUpdate = new HashMap<>();
        allItemsFromViewForUpdate.stream()
                .forEach((Object[] u) -> itemsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<Item> itemListForUpdate = new ArrayList<>();
        itemListForUpdate.addAll(dao.findAllById(itemsFetchedForUpdate.keySet()));
        itemListForUpdate.stream()
                .forEach(u -> u.setName(itemsFetchedForUpdate.get(u.getId())));
        List<Object[]> allItemsFromViewForInsert = dao.itemsForInsert();
        Stream<Item> itemStream = allItemsFromViewForInsert
                .stream()
                .map(u -> new Item()
                        .setId(Long.valueOf(u[0].toString()))
                        .setName(u[1].toString()));
        List<Item> itemList = itemStream.collect(Collectors.toList());
        itemListForUpdate.addAll(itemList);
        dao.saveAll(itemListForUpdate);
    }

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public Item get(Long id) {
        final Optional<Item> slById = dao.findById(id);
        final Item item = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));

        return item;
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public List<Item> list() {
        final List<Item> slAll = dao.findAll();

        return modelMapper.map(slAll, new TypeToken<List<GoodsDTO.Info>>() {
        }.getType());
    }


    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public TotalResponse<Item> search(NICICOCriteria criteria) {
        return SearchUtil.search(dao, criteria, item -> item);
    }

}
