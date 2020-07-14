package com.nicico.sales.iservice;


import com.nicico.sales.dto.CurrencyRateDTO;
import com.nicico.sales.model.entities.base.CurrencyRate;
import org.springframework.stereotype.Repository;


@Repository
public interface ICurrencyRateService extends IGenericService<CurrencyRate, Long, CurrencyRateDTO.Create, CurrencyRateDTO.Info, CurrencyRateDTO.Update, CurrencyRateDTO.Delete> {

}

