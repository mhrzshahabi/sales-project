package com.nicico.sales.service;


import com.nicico.sales.dto.CurrencyDTO;
import com.nicico.sales.iservice.ICurrencyService;
import com.nicico.sales.model.entities.base.Currency;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class CurrencyService  extends GenericService<Currency, Long, CurrencyDTO.Create, CurrencyDTO.Info, CurrencyDTO.Update, CurrencyDTO.Delete> implements ICurrencyService {

}