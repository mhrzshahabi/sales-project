package com.nicico.sales.service;


import com.nicico.sales.dto.CountryDTO;
import com.nicico.sales.iservice.ICountryService;
import com.nicico.sales.model.entities.base.Country;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class CountryService extends GenericService<Country, Long, CountryDTO.Create, CountryDTO.Info, CountryDTO.Update, CountryDTO.Delete> implements ICountryService {

}