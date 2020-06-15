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

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class ItemService implements IItemService {

    private final ItemDAO dao;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public void updateFromTozinView() {
        List<Object[]> allItemsFromViewForUpdate = dao.itemsForUpdate();
        Map<Long, String> ItemsFetchedForUpdate = new HashMap<>();
        allItemsFromViewForUpdate.stream()
                .forEach((Object[] u) -> ItemsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<Item> ItemListForUpdate = dao.findAllById(ItemsFetchedForUpdate.keySet());
        ItemListForUpdate.stream()
                .forEach(u -> u.setName(ItemsFetchedForUpdate.get(u.getId())));
        List<Object[]> allItemsFromViewForInsert = dao.itemsForInsert();
        ItemListForUpdate.addAll(allItemsFromViewForInsert
                .stream()
                .map(u -> new Item()
                        .setId(Long.valueOf(u[0].toString()))
                        .setName(u[1].toString()))
                .collect(Collectors.toList()));
        dao.saveAll(ItemListForUpdate);
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
