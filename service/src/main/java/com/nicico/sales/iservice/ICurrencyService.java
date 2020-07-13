package com.nicico.sales.iservice;


import com.nicico.sales.dto.CurrencyDTO;
import com.nicico.sales.model.entities.base.Currency;
import org.springframework.stereotype.Repository;


@Repository
public interface ICurrencyService extends IGenericService<Currency, Long , CurrencyDTO.Create , CurrencyDTO.Info , CurrencyDTO.Update , CurrencyDTO.Delete> {

}
