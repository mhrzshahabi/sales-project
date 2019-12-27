package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.MaterialFeatureDTO;
import com.nicico.sales.iservice.IMaterialFeatureService;
import com.nicico.sales.model.entities.base.MaterialFeature;
import com.nicico.sales.repository.MaterialFeatureDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class MaterialFeatureService implements IMaterialFeatureService {

    private final MaterialFeatureDAO materialFeatureDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public MaterialFeatureDTO.Info get(Long id) {
        final Optional<MaterialFeature> slById = materialFeatureDAO.findById(id);
        final MaterialFeature materialFeature = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.MaterialFeatureNotFound));

        return modelMapper.map(materialFeature, MaterialFeatureDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<MaterialFeatureDTO.Info> list() {
        final List<MaterialFeature> slAll = materialFeatureDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<MaterialFeatureDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    public MaterialFeatureDTO.Info create(MaterialFeatureDTO.Create request) {
        final MaterialFeature materialFeature = modelMapper.map(request, MaterialFeature.class);

        return save(materialFeature);
    }

    @Transactional
    @Override
    public MaterialFeatureDTO.Info update(Long id, MaterialFeatureDTO.Update request) {
        final Optional<MaterialFeature> slById = materialFeatureDAO.findById(id);
        final MaterialFeature materialFeature = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.MaterialFeatureNotFound));

        MaterialFeature updating = new MaterialFeature();
        modelMapper.map(materialFeature, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    public void delete(Long id) {
        materialFeatureDAO.deleteById(id);
    }

    @Transactional
    @Override
    public void delete(MaterialFeatureDTO.Delete request) {
        final List<MaterialFeature> materialFeatures = materialFeatureDAO.findAllById(request.getIds());

        materialFeatureDAO.deleteAll(materialFeatures);
    }

    @Transactional(readOnly = true)
    @Override
    public SearchDTO.SearchRs<MaterialFeatureDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(materialFeatureDAO, request, materialFeature -> modelMapper.map(materialFeature, MaterialFeatureDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_BANK')")
    public TotalResponse<MaterialFeatureDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(materialFeatureDAO, criteria, materialFeature -> modelMapper.map(materialFeature, MaterialFeatureDTO.Info.class));
    }

    private MaterialFeatureDTO.Info save(MaterialFeature materialFeature) {
        final MaterialFeature saved = materialFeatureDAO.saveAndFlush(materialFeature);
        return modelMapper.map(saved, MaterialFeatureDTO.Info.class);
    }
}
