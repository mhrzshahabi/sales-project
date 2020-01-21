package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.GridResponse;
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
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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
    @PreAuthorize("hasAuthority('R_WAREHOUSE_CAD')")
    public WarehouseCadDTO.Info get(Long id) {
        final Optional<WarehouseCad> slById = warehouseCadDAO.findById(id);
        final WarehouseCad warehouseCad = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.WarehouseCadNotFound));

        return modelMapper.map(warehouseCad, WarehouseCadDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_CAD')")
    public List<WarehouseCadDTO.Info> list() {
        final List<WarehouseCad> slAll = warehouseCadDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<WarehouseCadDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_WAREHOUSE_CAD')")
    public WarehouseCadDTO.Info create(WarehouseCadDTO.Create request) {
        final WarehouseCad warehouseCad = modelMapper.map(request, WarehouseCad.class);
        MaterialItem materialItem = materialItemDAO.findByGdsCode(String.valueOf(request.getMaterialItemId()));
        warehouseCad.setMaterialItem(materialItem);
        warehouseCad.setMaterialItemId(materialItem.getId());
        WarehouseCadDTO.Info saved = save(warehouseCad);
        warehouseCad.getWarehouseCadItems().forEach(warehouseCadItem -> {
            warehouseCadItem.setWarehouseCadId(saved.getId());
            warehouseCadItemService.save(warehouseCadItem, null);
        });
        return saved;
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_WAREHOUSE_CAD')")
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
    @PreAuthorize("hasAuthority('D_WAREHOUSE_CAD')")
    public void delete(Long id) {
        warehouseCadDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_WAREHOUSE_CAD')")
    public void delete(WarehouseCadDTO.Delete request) {
        final List<WarehouseCad> warehouseCads = warehouseCadDAO.findAllById(request.getIds());

        warehouseCadDAO.deleteAll(warehouseCads);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_CAD')")
    public TotalResponse<WarehouseCadDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(warehouseCadDAO, criteria, warehouseCad -> modelMapper.map(warehouseCad, WarehouseCadDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_CAD')")
    public TotalResponse<WarehouseCadDTO.InfoCombo> search1(NICICOCriteria criteria) {
        List<WarehouseCad> l = warehouseCadDAO.findOnHandsByHSCode("74031100");
        GridResponse<WarehouseCadDTO.InfoCombo> gridResponse = new GridResponse();
        List<WarehouseCadDTO.InfoCombo> data = new ArrayList<>();
        for (WarehouseCad w : l) {
            data.add(modelMapper.map(w, WarehouseCadDTO.InfoCombo.class));
        }
        gridResponse.setStartRow(0);
        gridResponse.setEndRow(data.size() - 1);
        gridResponse.setTotalRows(data.size());
        gridResponse.setData(data);
        return new TotalResponse<>(gridResponse);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_WAREHOUSE_CAD')")
    public SearchDTO.SearchRs<WarehouseCadDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(warehouseCadDAO, request, entity -> modelMapper.map(entity, WarehouseCadDTO.Info.class));
    }

    private WarehouseCadDTO.Info save(WarehouseCad warehouseCad) {
        if (warehouseCad.getPlant().equals("مجتمع مس شهربابك -ميدوك ") || warehouseCad.getPlant().equals("مجتمع مس شهربابك - خاتون آباد "))
            warehouseCad.setPlant("Miduk");
        if (warehouseCad.getPlant().equals("بندرعباس") || warehouseCad.getPlant().equals("اسكله شهيد رجائي "))
            warehouseCad.setPlant("BandarAbbas");
        if (warehouseCad.getPlant().equals("ايستگاه قطار تبريز") || warehouseCad.getPlant().equals("مجتمع مس سونگون "))
            warehouseCad.setPlant("sungun");
        if (warehouseCad.getPlant().equals("مجتمع مس سرچشمه"))
            warehouseCad.setPlant("Sarcheshmeh");
        final WarehouseCad saved = warehouseCadDAO.saveAndFlush(warehouseCad);
        return modelMapper.map(saved, WarehouseCadDTO.Info.class);
    }
}
