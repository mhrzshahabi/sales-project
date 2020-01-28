package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.RateDTO;
import com.nicico.sales.iservice.IRateService;
import com.nicico.sales.model.entities.base.Rate;
import com.nicico.sales.repository.RateDAO;
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
public class RateService implements IRateService {

    private final RateDAO rateDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_RATE')")
    public RateDTO.Info get(Long id) {
        final Optional<Rate> slById = rateDAO.findById(id);
        final Rate rate = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.RateNotFound));

        return modelMapper.map(rate, RateDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_RATE')")
    public List<RateDTO.Info> list() {
        final List<Rate> slAll = rateDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<RateDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_RATE')")
    public RateDTO.Info create(RateDTO.Create request) {
        final Rate rate = modelMapper.map(request, Rate.class);

        return save(rate);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_RATE')")
    public RateDTO.Info update(Long id, RateDTO.Update request) {
        final Optional<Rate> slById = rateDAO.findById(id);
        final Rate rate = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.RateNotFound));

        Rate updating = new Rate();
        modelMapper.map(rate, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_RATE')")
    public void delete(Long id) {
        rateDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_RATE')")
    public void delete(RateDTO.Delete request) {
        final List<Rate> rates = rateDAO.findAllById(request.getIds());

        rateDAO.deleteAll(rates);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_RATE')")
    public TotalResponse<RateDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(rateDAO, criteria, rate -> modelMapper.map(rate, RateDTO.Info.class));
    }

    private RateDTO.Info save(Rate rate) {
        final Rate saved = rateDAO.saveAndFlush(rate);
        return modelMapper.map(saved, RateDTO.Info.class);
    }
}
