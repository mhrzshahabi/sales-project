package com.nicico.sales.service;

import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.iservice.IBankService;
import com.nicico.sales.model.entities.base.Bank;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class BankService extends GenericService<Bank, Long, BankDTO.Create, BankDTO.Info, BankDTO.Update, BankDTO.Delete> implements IBankService {

}
