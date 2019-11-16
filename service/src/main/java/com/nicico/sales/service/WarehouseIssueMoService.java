package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseIssueMoDTO;
import com.nicico.sales.iservice.IWarehouseIssueMoService;
import com.nicico.sales.model.entities.base.WarehouseIssueMo;
import com.nicico.sales.repository.WarehouseIssueMoDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseIssueMoService implements IWarehouseIssueMoService {

    private final WarehouseIssueMoDAO warehouseIssueMoDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
    public WarehouseIssueMoDTO.Info get(Long id) {
        final Optional<WarehouseIssueMo> slById = warehouseIssueMoDAO.findById(id);
        final WarehouseIssueMo warehouseIssueMo = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueMoNotFound));

        return modelMapper.map(warehouseIssueMo, WarehouseIssueMoDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
    public List<WarehouseIssueMoDTO.Info> list() {
        final List<WarehouseIssueMo> slAll = warehouseIssueMoDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseIssueMoDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_WAREHOUSEISSUEMO')")
    public WarehouseIssueMoDTO.Info create(WarehouseIssueMoDTO.Create request) {
        final WarehouseIssueMo warehouseIssueMo = modelMapper.map(request, WarehouseIssueMo.class);

        return save(warehouseIssueMo);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_WAREHOUSEISSUEMO')")
    public WarehouseIssueMoDTO.Info update(Long id, WarehouseIssueMoDTO.Update request) {
        final Optional<WarehouseIssueMo> slById = warehouseIssueMoDAO.findById(id);
        final WarehouseIssueMo warehouseIssueMo = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseIssueMoNotFound));

        WarehouseIssueMo updating = new WarehouseIssueMo();
        modelMapper.map(warehouseIssueMo, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUEMO')")
    public void delete(Long id) {
        warehouseIssueMoDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSEISSUEMO')")
    public void delete(WarehouseIssueMoDTO.Delete request) {
        final List<WarehouseIssueMo> warehouseIssueMos = warehouseIssueMoDAO.findAllById(request.getIds());

        warehouseIssueMoDAO.deleteAll(warehouseIssueMos);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
    public TotalResponse<WarehouseIssueMoDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseIssueMoDAO, criteria, warehouseIssueMo -> modelMapper.map(warehouseIssueMo, WarehouseIssueMoDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSEISSUEMO')")
    public SearchDTO.SearchRs<WarehouseIssueMoDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(warehouseIssueMoDAO, request, entity -> modelMapper.map(entity, WarehouseIssueMoDTO.Info.class));
    }

    private WarehouseIssueMoDTO.Info save(WarehouseIssueMo warehouseIssueMo) {
        final WarehouseIssueMo saved = warehouseIssueMoDAO.saveAndFlush(warehouseIssueMo);
        return modelMapper.map(saved, WarehouseIssueMoDTO.Info.class);
    }
}
