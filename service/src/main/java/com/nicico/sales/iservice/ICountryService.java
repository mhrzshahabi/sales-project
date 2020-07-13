package com.nicico.sales.iservice;


import com.nicico.sales.dto.CountryDTO;
import com.nicico.sales.model.entities.base.Country;

public interface ICountryService extends IGenericService<Country, Long , CountryDTO.Create , CountryDTO.Info , CountryDTO.Update , CountryDTO.Delete> {

}
