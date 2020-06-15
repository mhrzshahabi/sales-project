package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseDTO;
import com.nicico.sales.iservice.IWarehouseService2;
import com.nicico.sales.model.entities.base.Warehouse2;
import com.nicico.sales.repository.WarehouseDAO2;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseService2 implements IWarehouseService2 {

    private final WarehouseDAO2 warehouseDAO2;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public void updateFromTozinView() {
        warehouseDAO2.deleteAll();
        warehouseDAO2.updateFromTozinView();
    }

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public WarehouseDTO.Info get(Long id) {
        final Optional<Warehouse2> slById = warehouseDAO2.findById(id);
        final Warehouse2 warehouse2 = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.NotFound));

        return modelMapper.map(warehouse2, WarehouseDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public List<WarehouseDTO.Info> list() {
        final List<Warehouse2> slAll = warehouseDAO2.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseDTO.Info>>() {
        }.getType());
    }


    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSE_')")
    public TotalResponse<WarehouseDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseDAO2, criteria, warehouse2 -> modelMapper.map(warehouse2, WarehouseDTO.Info.class));
    }

}
