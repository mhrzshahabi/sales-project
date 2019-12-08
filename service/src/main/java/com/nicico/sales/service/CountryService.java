package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.CountryDTO;
import com.nicico.sales.iservice.ICountryService;
import com.nicico.sales.model.entities.base.Country;
import com.nicico.sales.repository.CountryDAO;
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
public class CountryService implements ICountryService {

    private final CountryDAO countryDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_COUNTRY')")
    public CountryDTO.Info get(Long id) {
        final Optional<Country> slById = countryDAO.findById(id);
        final Country country = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CountryNotFound));

        return modelMapper.map(country, CountryDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_COUNTRY')")
    public List<CountryDTO.Info> list() {
        final List<Country> slAll = countryDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<CountryDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_COUNTRY')")
    public CountryDTO.Info create(CountryDTO.Create request) {
        final Country country = modelMapper.map(request, Country.class);

        return save(country);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_COUNTRY')")
    public CountryDTO.Info update(Long id, CountryDTO.Update request) {
        final Optional<Country> slById = countryDAO.findById(id);
        final Country country = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.CountryNotFound));

        Country updating = new Country();
        modelMapper.map(country, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_COUNTRY')")
    public void delete(Long id) {
        countryDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_COUNTRY')")
    public void delete(CountryDTO.Delete request) {
        final List<Country> countrys = countryDAO.findAllById(request.getIds());

        countryDAO.deleteAll(countrys);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_COUNTRY')")
    public SearchDTO.SearchRs<CountryDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(countryDAO, request, country -> modelMapper.map(country, CountryDTO.Info.class));
    }

    private CountryDTO.Info save(Country country) {
        final Country saved = countryDAO.saveAndFlush(country);
        return modelMapper.map(saved, CountryDTO.Info.class);
    }
}
