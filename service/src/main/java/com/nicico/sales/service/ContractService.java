package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractDTO;
import com.nicico.sales.iservice.IContractService;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.repository.ContractDAO;
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
public class ContractService implements IContractService {

    private final ContractDAO contractDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
//    @PreAuthorize("hasAuthority('R_CONTRACT')")
    public ContractDTO.Info get(Long id) {
        final Optional<Contract> slById = contractDAO.findById(id);
        final Contract contract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractNotFound));

        return modelMapper.map(contract, ContractDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CONTRACT')")
    public List<ContractDTO.Info> list() {
        final List<Contract> slAll = contractDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContractDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('C_CONTRACT')")
    public ContractDTO.Info create(ContractDTO.Create request) {
        final Contract contract = modelMapper.map(request, Contract.class);

        return save(contract);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('U_CONTRACT')")
    public ContractDTO.Info update(Long id, ContractDTO.Update request) {
        final Optional<Contract> slById = contractDAO.findById(id);
        final Contract contract = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractNotFound));

        Contract updating = new Contract();
        modelMapper.map(contract, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CONTRACT')")
    public void delete(Long id) {
        contractDAO.deleteById(id);
    }

    @Transactional
    @Override
//    @PreAuthorize("hasAuthority('D_CONTRACT')")
    public void delete(ContractDTO.Delete request) {
        final List<Contract> contracts = contractDAO.findAllById(request.getIds());

        contractDAO.deleteAll(contracts);
    }

    @Transactional(readOnly = true)
    @Override
//    @PreAuthorize("hasAuthority('R_CONTRACT')")
    public SearchDTO.SearchRs<ContractDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(contractDAO, request, contract -> modelMapper.map(contract, ContractDTO.Info.class));
    }

    private ContractDTO.Info save(Contract contract) {
        final Contract saved = contractDAO.saveAndFlush(contract);
        return modelMapper.map(saved, ContractDTO.Info.class);
    }
}
