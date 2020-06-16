package com.nicico.sales.service.warehouse;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.warehous.IItemDetailService;
import com.nicico.sales.model.entities.warehouse.ItemDetail;
import com.nicico.sales.repository.warehouse.ItemDetailDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ItemDetailService implements IItemDetailService {
    private final ItemDetailDAO itemDetailDAO;

    @Override
    public ItemDetail get(Long id) {
        final Optional<ItemDetail> one = itemDetailDAO.findById(id);
        final ItemDetail itemDetail = one.orElseThrow(() -> new NotFoundException());
        return itemDetail;
    }

    @Override
    public List<ItemDetail> list() {
        return itemDetailDAO.findAll();
    }

    @Override
    public TotalResponse<ItemDetail> search(NICICOCriteria request) {
        final TotalResponse<ItemDetail> response = SearchUtil.search(itemDetailDAO, request, entity -> entity);
        response.getResponse().getData().stream().forEach(itemDetail -> itemDetail.getItem().setItemDetails(null));
        return response;
    }

    @Override
    public SearchDTO.SearchRs<ItemDetail> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(itemDetailDAO, request, entity -> entity);

    }
}
