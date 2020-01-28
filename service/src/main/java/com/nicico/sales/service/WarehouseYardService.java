package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseYardDTO;
import com.nicico.sales.iservice.IWarehouseYardService;
import com.nicico.sales.model.entities.base.WarehouseYard;
import com.nicico.sales.repository.WarehouseYardDAO;
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
public class WarehouseYardService implements IWarehouseYardService {

    private final WarehouseYardDAO warehouseYardDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_WAREHOUSE_YARD')")
    public WarehouseYardDTO.Info get(Long id) {
        final Optional<WarehouseYard> slById = warehouseYardDAO.findById(id);
        final WarehouseYard warehouseYard = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseYardNotFound));

        return modelMapper.map(warehouseYard, WarehouseYardDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_YARD')")
    public List<WarehouseYardDTO.Info> list() {
        final List<WarehouseYard> slAll = warehouseYardDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseYardDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_WAREHOUSE_YARD')")
    public WarehouseYardDTO.Info create(WarehouseYardDTO.Create request) {
        final WarehouseYard warehouseYard = modelMapper.map(request, WarehouseYard.class);

        return save(warehouseYard);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_WAREHOUSE_YARD')")
    public WarehouseYardDTO.Info update(Long id, WarehouseYardDTO.Update request) {
        final Optional<WarehouseYard> slById = warehouseYardDAO.findById(id);
        final WarehouseYard warehouseYard = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseYardNotFound));

        WarehouseYard updating = new WarehouseYard();
        modelMapper.map(warehouseYard, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_YARD')")
    public void delete(Long id) {
        warehouseYardDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_YARD')")
    public void delete(WarehouseYardDTO.Delete request) {
        final List<WarehouseYard> warehouseYards = warehouseYardDAO.findAllById(request.getIds());

        warehouseYardDAO.deleteAll(warehouseYards);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_YARD')")
    public TotalResponse<WarehouseYardDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseYardDAO, criteria, warehouseYard -> modelMapper.map(warehouseYard, WarehouseYardDTO.Info.class));
    }

    private WarehouseYardDTO.Info save(WarehouseYard warehouseYard) {
        final WarehouseYard saved = warehouseYardDAO.saveAndFlush(warehouseYard);
        return modelMapper.map(saved, WarehouseYardDTO.Info.class);
    }
}
