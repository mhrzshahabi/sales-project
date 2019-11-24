package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.WarehouseCadDTO;
import com.nicico.sales.iservice.IWarehouseCadItemService;
import com.nicico.sales.iservice.IWarehouseCadService;
import com.nicico.sales.model.entities.base.MaterialItem;
import com.nicico.sales.model.entities.base.WarehouseCad;
import com.nicico.sales.repository.MaterialItemDAO;
import com.nicico.sales.repository.WarehouseCadDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class WarehouseCadService implements IWarehouseCadService {

    private final WarehouseCadDAO warehouseCadDAO;
    private final MaterialItemDAO materialItemDAO;
    private final IWarehouseCadItemService warehouseCadItemService;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_WAREHOUSECAD')")
    public WarehouseCadDTO.Info get(Long id) {
        final Optional<WarehouseCad> slById = warehouseCadDAO.findById(id);
        final WarehouseCad warehouseCad = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));

        return modelMapper.map(warehouseCad, WarehouseCadDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECAD')")
    public List<WarehouseCadDTO.Info> list() {
        final List<WarehouseCad> slAll = warehouseCadDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseCadDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_WAREHOUSECAD')")
    public WarehouseCadDTO.Info create(WarehouseCadDTO.Create request) {
        final WarehouseCad warehouseCad = modelMapper.map(request, WarehouseCad.class);
        MaterialItem materialItem = materialItemDAO.findByGdsCode(String.valueOf(request.getMaterialItemId()));
        warehouseCad.setMaterialItemId(materialItem.getId());
        WarehouseCadDTO.Info saved=save(warehouseCad);
        warehouseCad.getWarehouseCadItems().forEach(warehouseCadItem -> {
            warehouseCadItem.setWarehouseCadId(saved.getId());
            warehouseCadItemService.save(warehouseCadItem,null);
        });
        return saved;
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_WAREHOUSECAD')")
    public WarehouseCadDTO.Info update(Long id, WarehouseCadDTO.Update request) {
        final Optional<WarehouseCad> slById = warehouseCadDAO.findById(id);
        final WarehouseCad warehouseCad = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));

        WarehouseCad updating = new WarehouseCad();
        modelMapper.map(warehouseCad, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSECAD')")
    public void delete(Long id) {
        warehouseCadDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_WAREHOUSECAD')")
    public void delete(WarehouseCadDTO.Delete request) {
        final List<WarehouseCad> warehouseCads = warehouseCadDAO.findAllById(request.getIds());

        warehouseCadDAO.deleteAll(warehouseCads);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECAD')")
    public TotalResponse<WarehouseCadDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseCadDAO, criteria, warehouseCad -> modelMapper.map(warehouseCad, WarehouseCadDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_WAREHOUSECAD')")
    public SearchDTO.SearchRs<WarehouseCadDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(warehouseCadDAO, request, entity -> modelMapper.map(entity, WarehouseCadDTO.Info.class));
    }

    private WarehouseCadDTO.Info save(WarehouseCad warehouseCad) {
        final WarehouseCad saved = warehouseCadDAO.saveAndFlush(warehouseCad);
        return modelMapper.map(saved, WarehouseCadDTO.Info.class);
    }
}
