package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.MaterialDTO;
import com.nicico.sales.iservice.IMaterialService;
import com.nicico.sales.model.entities.base.Material;
import com.nicico.sales.repository.MaterialDAO;
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
public class MaterialService implements IMaterialService {

    private final MaterialDAO materialDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_MATERIAL')")
    public MaterialDTO.Info get(Long id) {
        final Optional<Material> slById = materialDAO.findById(id);
        final Material material = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.MaterialNotFound));

        return modelMapper.map(material, MaterialDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_MATERIAL')")
    public List<MaterialDTO.Info> list() {
        final List<Material> slAll = materialDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<MaterialDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_MATERIAL')")
    public MaterialDTO.Info create(MaterialDTO.Create request) {
        final Material material = modelMapper.map(request, Material.class);

        return save(material);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_MATERIAL')")
    public MaterialDTO.Info update(Long id, MaterialDTO.Update request) {
        final Optional<Material> slById = materialDAO.findById(id);
        final Material material = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.MaterialNotFound));

        Material updating = new Material();
        modelMapper.map(material, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_MATERIAL')")
    public void delete(Long id) {
        materialDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_MATERIAL')")
    public void delete(MaterialDTO.Delete request) {
        final List<Material> materials = materialDAO.findAllById(request.getIds());

        materialDAO.deleteAll(materials);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_MATERIAL')")
    public SearchDTO.SearchRs<MaterialDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(materialDAO, request, material -> modelMapper.map(material, MaterialDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_MATERIAL')")
    public TotalResponse<MaterialDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(materialDAO, criteria, material -> modelMapper.map(material, MaterialDTO.Info.class));
    }

    private MaterialDTO.Info save(Material material) {
        final Material saved = materialDAO.saveAndFlush(material);
        return modelMapper.map(saved, MaterialDTO.Info.class);
    }
}
