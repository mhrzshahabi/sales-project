package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.WarehouseStockDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IWarehouseStockService;
import com.nicico.sales.model.entities.base.WarehouseStock;
import com.nicico.sales.repository.WarehouseStockDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseStockService implements IWarehouseStockService {

    private final WarehouseStockDAO warehouseStockDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_WAREHOUSE_STOCK')")
    public WarehouseStockDTO.Info get(Long id) {
        final Optional<WarehouseStock> slById = warehouseStockDAO.findById(id);
        final WarehouseStock warehouseStock = slById.orElseThrow(() -> new NotFoundException(WarehouseStock.class));

        return modelMapper.map(warehouseStock, WarehouseStockDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_STOCK')")
    public List<WarehouseStockDTO.Info> list() {
        final List<WarehouseStock> slAll = warehouseStockDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseStockDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_WAREHOUSE_STOCK')")
    public WarehouseStockDTO.Info create(WarehouseStockDTO.Create request) {
        final WarehouseStock warehouseStock = modelMapper.map(request, WarehouseStock.class);

        return save(warehouseStock);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_WAREHOUSE_STOCK')")
    public WarehouseStockDTO.Info update(Long id, WarehouseStockDTO.Update request) {
        final Optional<WarehouseStock> slById = warehouseStockDAO.findById(id);
        final WarehouseStock warehouseStock = slById.orElseThrow(() -> new NotFoundException(WarehouseStock.class));

        WarehouseStock updating = new WarehouseStock();
        modelMapper.map(warehouseStock, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_STOCK')")
    public void delete(Long id) {
        warehouseStockDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_STOCK')")
    public void delete(WarehouseStockDTO.Delete request) {
        final List<WarehouseStock> warehouseStocks = warehouseStockDAO.findAllById(request.getIds());

        warehouseStockDAO.deleteAll(warehouseStocks);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_STOCK')")
    public TotalResponse<WarehouseStockDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseStockDAO, criteria, warehouseStock -> modelMapper.map(warehouseStock, WarehouseStockDTO.Info.class));
    }

    private WarehouseStockDTO.Info save(WarehouseStock warehouseStock) {
        final WarehouseStock saved = warehouseStockDAO.saveAndFlush(warehouseStock);
        return modelMapper.map(saved, WarehouseStockDTO.Info.class);
    }

    @PreAuthorize("hasAuthority('R_WAREHOUSE_STOCK')")
    public List<Object[]> warehouseStockConc() {
        return warehouseStockDAO.warehouseStockConc();
    }
}
