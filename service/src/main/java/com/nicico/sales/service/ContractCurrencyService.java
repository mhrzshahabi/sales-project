package com.nicico.sales.service;

import com.nicico.sales.dto.ContractCurrencyDTO;
import com.nicico.sales.iservice.IContractCurrencyService;
import com.nicico.sales.model.entities.base.ContractCurrency;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class ContractCurrencyService extends GenericService<ContractCurrency, Long, ContractCurrencyDTO.Create, ContractCurrencyDTO.Info, ContractCurrencyDTO.Update, ContractCurrencyDTO.Delete> implements IContractCurrencyService {

}
