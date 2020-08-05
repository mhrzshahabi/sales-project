package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.BankDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IBankService;
import com.nicico.sales.model.entities.base.Bank;
import com.nicico.sales.repository.BankDAO;
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
public class BankService implements IBankService {

    private final BankDAO bankDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_BANK')")
    public BankDTO.Info get(Long id) {
        final Optional<Bank> slById = bankDAO.findById(id);
        final Bank bank = slById.orElseThrow(() -> new NotFoundException(Bank.class));

        return modelMapper.map(bank, BankDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_BANK')")
    public List<BankDTO.Info> list() {
        final List<Bank> slAll = bankDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<BankDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_BANK')")
    public BankDTO.Info create(BankDTO.Create request) {
        final Bank bank = modelMapper.map(request, Bank.class);

        return save(bank);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_BANK')")
    public BankDTO.Info update(Long id, BankDTO.Update request) {
        final Optional<Bank> slById = bankDAO.findById(id);
        final Bank bank = slById.orElseThrow(() -> new NotFoundException(Bank.class));

        Bank updating = new Bank();
        modelMapper.map(bank, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_BANK')")
    public void delete(Long id) {
        bankDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_BANK')")
    public void delete(BankDTO.Delete request) {
        final List<Bank> banks = bankDAO.findAllById(request.getIds());

        bankDAO.deleteAll(banks);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_BANK')")
    public TotalResponse<BankDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(bankDAO, criteria, bank -> modelMapper.map(bank, BankDTO.Info.class));
    }

    private BankDTO.Info save(Bank bank) {
        final Bank saved = bankDAO.saveAndFlush(bank);
        return modelMapper.map(saved, BankDTO.Info.class);
    }
}
