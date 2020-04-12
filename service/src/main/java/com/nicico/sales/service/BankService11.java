package com.nicico.sales.service;

import com.nicico.sales.SalesException;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.iservice.IBankService11;
import com.nicico.sales.model.entities.base.Bank;
import com.nicico.sales.repository.BankDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@RequiredArgsConstructor
@Service
public class BankService11 extends GenericService<Bank, Long, BankDTO.Create, BankDTO.Info, BankDTO.Update, BankDTO.Delete> implements IBankService11 {

    private final BankDAO bankDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_BANK')")
    public BankDTO.Info get(Long id) {
        final Optional<Bank> slById = bankDAO.findById(id);
        final Bank bank = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.BankNotFound));

        return modelMapper.map(bank, BankDTO.Info.class);
    }

    @Override
    public void delete(BankDTO.Delete request) {

    }
}
