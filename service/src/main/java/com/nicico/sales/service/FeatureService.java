package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.FeatureDTO;
import com.nicico.sales.iservice.IFeatureService;
import com.nicico.sales.model.entities.base.Feature;
import com.nicico.sales.repository.FeatureDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class FeatureService implements IFeatureService {

    private final FeatureDAO featureDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public FeatureDTO.Info get(Long id) {
        final Optional<Feature> slById = featureDAO.findById(id);
        final Feature feature = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.FeatureNotFound));

        return modelMapper.map(feature, FeatureDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<FeatureDTO.Info> list() {
        final List<Feature> slAll = featureDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<FeatureDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    public FeatureDTO.Info create(FeatureDTO.Create request) {
        final Feature feature = modelMapper.map(request, Feature.class);

        return save(feature);
    }

    @Transactional
    @Override
    public FeatureDTO.Info update(Long id, FeatureDTO.Update request) {
        final Optional<Feature> slById = featureDAO.findById(id);
        final Feature feature = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.FeatureNotFound));

        Feature updating = new Feature();
        modelMapper.map(feature, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    public void delete(Long id) {
        featureDAO.deleteById(id);
    }

    @Transactional
    @Override
    public void delete(FeatureDTO.Delete request) {
        final List<Feature> features = featureDAO.findAllById(request.getIds());

        featureDAO.deleteAll(features);
    }

    @Transactional(readOnly = true)
    @Override
    public SearchDTO.SearchRs<FeatureDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(featureDAO, request, feature -> modelMapper.map(feature, FeatureDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_BANK')")
    public TotalResponse<FeatureDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(featureDAO, criteria, feature -> modelMapper.map(feature, FeatureDTO.Info.class));
    }

    private FeatureDTO.Info save(Feature feature) {
        final Feature saved = featureDAO.saveAndFlush(feature);
        return modelMapper.map(saved, FeatureDTO.Info.class);
    }
}
