package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.CurrencyRateDTO;
import com.nicico.sales.iservice.ICurrencyRateService;
import com.nicico.sales.model.entities.base.CurrencyRate;
import com.nicico.sales.repository.CurrencyRateDAO;
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
public class CurrencyRateService implements ICurrencyRateService {

    private final CurrencyRateDAO currencyRateDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_CURRENCY_RATE')")
    public CurrencyRateDTO.Info get(Long id) {
        final Optional<CurrencyRate> slById = currencyRateDAO.findById(id);
        final CurrencyRate currencyRate = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CurrencyRateNotFound));

        return modelMapper.map(currencyRate, CurrencyRateDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CURRENCY_RATE')")
    public List<CurrencyRateDTO.Info> list() {
        final List<CurrencyRate> slAll = currencyRateDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<CurrencyRateDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_CURRENCY_RATE')")
    public CurrencyRateDTO.Info create(CurrencyRateDTO.Create request) {
        final CurrencyRate currencyRate = modelMapper.map(request, CurrencyRate.class);

        return save(currencyRate);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_CURRENCY_RATE')")
    public CurrencyRateDTO.Info update(Long id, CurrencyRateDTO.Update request) {
        final Optional<CurrencyRate> slById = currencyRateDAO.findById(id);
        final CurrencyRate currencyRate = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CurrencyRateNotFound));

        CurrencyRate updating = new CurrencyRate();
        modelMapper.map(currencyRate, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CURRENCY_RATE')")
    public void delete(Long id) {
        currencyRateDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CURRENCY_RATE')")
    public void delete(CurrencyRateDTO.Delete request) {
        final List<CurrencyRate> currencyRates = currencyRateDAO.findAllById(request.getIds());

        currencyRateDAO.deleteAll(currencyRates);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CURRENCY_RATE')")
    public SearchDTO.SearchRs<CurrencyRateDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(currencyRateDAO, request, currencyRate -> modelMapper.map(currencyRate, CurrencyRateDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CURRENCY_RATE')")
    public TotalResponse<CurrencyRateDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(currencyRateDAO, criteria, currencyRate -> modelMapper.map(currencyRate, CurrencyRateDTO.Info.class));
    }

    private CurrencyRateDTO.Info save(CurrencyRate currencyRate) {
        final CurrencyRate saved = currencyRateDAO.saveAndFlush(currencyRate);
        return modelMapper.map(saved, CurrencyRateDTO.Info.class);
    }
}
