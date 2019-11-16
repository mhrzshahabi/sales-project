package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseIssueCathodeDTO;
import com.nicico.sales.iservice.IWarehouseIssueCathodeService;
import com.nicico.sales.model.entities.base.WarehouseIssueCathode;
import com.nicico.sales.repository.WarehouseIssueCathodeDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseIssueCathodeService implements IWarehouseIssueCathodeService {

    private final WarehouseIssueCathodeDAO warehouseIssueCathodeDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECATHODE')")
    public WarehouseIssueCathodeDTO.Info get(Long id) {
        final Optional<WarehouseIssueCathode> slById = warehouseIssueCathodeDAO.findById(id);
        final WarehouseIssueCathode warehouseIssueCathode = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueCathodeNotFound));

        return modelMapper.map(warehouseIssueCathode, WarehouseIssueCathodeDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECATHODE')")
    public List<WarehouseIssueCathodeDTO.Info> list() {
        final List<WarehouseIssueCathode> slAll = warehouseIssueCathodeDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseIssueCathodeDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_WAREHOUSEISSUECATHODE')")
    public WarehouseIssueCathodeDTO.Info create(WarehouseIssueCathodeDTO.Create request) {
        final WarehouseIssueCathode warehouseIssueCathode = modelMapper.map(request, WarehouseIssueCathode.class);

        return save(warehouseIssueCathode);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_WAREHOUSEISSUECATHODE')")
    public WarehouseIssueCathodeDTO.Info update(Long id, WarehouseIssueCathodeDTO.Update request) {
        final Optional<WarehouseIssueCathode> slById = warehouseIssueCathodeDAO.findById(id);
        final WarehouseIssueCathode warehouseIssueCathode = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueCathodeNotFound));

        WarehouseIssueCathode updating = new WarehouseIssueCathode();
        modelMapper.map(warehouseIssueCathode, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUECATHODE')")
    public void delete(Long id) {
        warehouseIssueCathodeDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUECATHODE')")
    public void delete(WarehouseIssueCathodeDTO.Delete request) {
        final List<WarehouseIssueCathode> warehouseIssueCathodes = warehouseIssueCathodeDAO.findAllById(request.getIds());

        warehouseIssueCathodeDAO.deleteAll(warehouseIssueCathodes);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECATHODE')")
    public TotalResponse<WarehouseIssueCathodeDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseIssueCathodeDAO, criteria, warehouseIssueCathode -> modelMapper.map(warehouseIssueCathode, WarehouseIssueCathodeDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUECATHODE')")
    public SearchDTO.SearchRs<WarehouseIssueCathodeDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(warehouseIssueCathodeDAO, request, entity -> modelMapper.map(entity, WarehouseIssueCathodeDTO.Info.class));
    }

    private WarehouseIssueCathodeDTO.Info save(WarehouseIssueCathode warehouseIssueCathode) {
        final WarehouseIssueCathode saved = warehouseIssueCathodeDAO.saveAndFlush(warehouseIssueCathode);
        return modelMapper.map(saved, WarehouseIssueCathodeDTO.Info.class);
    }
}
