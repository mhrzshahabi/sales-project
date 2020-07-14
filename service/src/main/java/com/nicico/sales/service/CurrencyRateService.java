package com.nicico.sales.service;


import com.nicico.sales.dto.CurrencyRateDTO;
import com.nicico.sales.dto.UnitDTO;
import com.nicico.sales.iservice.ICurrencyRateService;
import com.nicico.sales.iservice.IUnitService;
import com.nicico.sales.model.entities.base.CurrencyRate;
import com.nicico.sales.model.entities.base.Unit;
import com.nicico.sales.repository.CurrencyRateDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class CurrencyRateService extends GenericService<CurrencyRate, Long, CurrencyRateDTO.Create, CurrencyRateDTO.Info, CurrencyRateDTO.Update, CurrencyRateDTO.Delete> implements ICurrencyRateService {

}