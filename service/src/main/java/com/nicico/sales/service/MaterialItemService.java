package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.MaterialItemDTO;
import com.nicico.sales.iservice.IMaterialItemService;
import com.nicico.sales.model.entities.base.MaterialItem;
import com.nicico.sales.repository.MaterialDAO;
import com.nicico.sales.repository.MaterialItemDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class MaterialItemService implements IMaterialItemService {

    private final MaterialItemDAO materialItemDAO;
    private final MaterialDAO materialDAO;
    private final ModelMapper modelMapper;

    @Override
    public void updateFromTozinView() {
        List<Object[]> allItemsFromViewForUpdate = materialItemDAO.itemsForUpdate();
        Map<Long, String> ItemsFetchedForUpdate = new HashMap<>();
        allItemsFromViewForUpdate.stream()
                .forEach((Object[] u) -> ItemsFetchedForUpdate.put(Long.valueOf(u[0].toString()), u[1].toString()));
        List<MaterialItem> materialItems = new ArrayList<>();
        materialItems.addAll(materialItemDAO.findAllById(ItemsFetchedForUpdate.keySet()));
        materialItems.stream()
                .forEach(u -> u.setGdsName(ItemsFetchedForUpdate.get(u.getId()))
                        .setGdsCode(u.getId())
                );
        List<Object[]> allItemsFromViewForInsert = materialItemDAO.itemsForInsert();
        materialItems.addAll(allItemsFromViewForInsert
                .stream()
                .map(u -> new MaterialItem()
                        .setId(Long.valueOf(u[0].toString()))
                        .setGdsCode(Long.valueOf(u[0].toString()))
                        .setGdsName(u[1].toString())
                        .setMaterialId(-1L)
                )
                .collect(Collectors.toList()));
        materialItemDAO.saveAll(materialItems);
    }

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_MATERIAL_ITEM')")
    public MaterialItemDTO.Info get(Long id) {
        final Optional<MaterialItem> slById = materialItemDAO.findById(id);
        final MaterialItem materialItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.MaterialItemNotFound));

        return modelMapper.map(materialItem, MaterialItemDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_MATERIAL_ITEM')")
    public List<MaterialItemDTO.Info> list() {
        final List<MaterialItem> slAll = materialItemDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<MaterialItemDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_MATERIAL_ITEM')")
    public MaterialItemDTO.Info create(MaterialItemDTO.Create request) {
        final MaterialItem materialItem = modelMapper.map(request, MaterialItem.class);

        return save(materialItem);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_MATERIAL_ITEM')")
    public MaterialItemDTO.Info update(Long id, MaterialItemDTO.Update request) {
        final Optional<MaterialItem> slById = materialItemDAO.findById(id);
        final MaterialItem materialItem = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.MaterialItemNotFound));

        MaterialItem updating = new MaterialItem();
        modelMapper.map(materialItem, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_MATERIAL_ITEM')")
    public void delete(Long id) {
        materialItemDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_MATERIAL_ITEM')")
    public void delete(MaterialItemDTO.Delete request) {
        final List<MaterialItem> materialItems = materialItemDAO.findAllById(request.getIds());

        materialItemDAO.deleteAll(materialItems);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_MATERIAL_ITEM')")
    public TotalResponse<MaterialItemDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(materialItemDAO, criteria, materialItem -> modelMapper.map(materialItem, MaterialItemDTO.Info.class));
    }

    private MaterialItemDTO.Info save(MaterialItem materialItem) {
        final MaterialItem saved = materialItemDAO.saveAndFlush(materialItem);
        return modelMapper.map(saved, MaterialItemDTO.Info.class);
    }
}
