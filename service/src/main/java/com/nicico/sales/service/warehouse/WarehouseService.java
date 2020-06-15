package com.nicico.sales.service.warehouse;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.warehous.IWarehouseService;
import com.nicico.sales.model.entities.warehouse.Warehouse;
import com.nicico.sales.repository.warehouse.WarehouseDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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
    public SearchDTO.SearchRs<Warehouse> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(warehouseDAO, request, entity -> entity);

    }
}
