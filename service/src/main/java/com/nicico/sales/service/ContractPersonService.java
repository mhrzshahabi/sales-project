package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractPersonDTO;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IContractPersonService;
import com.nicico.sales.model.entities.base.ContractPerson;
import com.nicico.sales.repository.ContractPersonDAO;
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
public class ContractPersonService implements IContractPersonService {

    private final ContractPersonDAO contractPersonDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_CONTRACT_PERSON')")
    public ContractPersonDTO.Info get(Long id) {
        final Optional<ContractPerson> slById = contractPersonDAO.findById(id);
        final ContractPerson contractPerson = slById.orElseThrow(() -> new NotFoundException(ContractPerson.class));

        return modelMapper.map(contractPerson, ContractPersonDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_PERSON')")
    public List<ContractPersonDTO.Info> list() {
        final List<ContractPerson> slAll = contractPersonDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContractPersonDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_CONTRACT_PERSON')")
    public ContractPersonDTO.Info create(ContractPersonDTO.Create request) {
        final ContractPerson contractPerson = modelMapper.map(request, ContractPerson.class);

        return save(contractPerson);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_CONTRACT_PERSON')")
    public ContractPersonDTO.Info update(Long id, ContractPersonDTO.Update request) {
        final Optional<ContractPerson> slById = contractPersonDAO.findById(id);
        final ContractPerson contractPerson = slById.orElseThrow(() -> new NotFoundException(ContractPerson.class));

        ContractPerson updating = new ContractPerson();
        modelMapper.map(contractPerson, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTRACT_PERSON')")
    public void delete(Long id) {
        contractPersonDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTRACT_PERSON')")
    public void delete(ContractPersonDTO.Delete request) {
        final List<ContractPerson> contractPersons = contractPersonDAO.findAllById(request.getIds());

        contractPersonDAO.deleteAll(contractPersons);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_PERSON')")
    public TotalResponse<ContractPersonDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(contractPersonDAO, criteria, contractPerson -> modelMapper.map(contractPerson, ContractPersonDTO.Info.class));
    }

    private ContractPersonDTO.Info save(ContractPerson contractPerson) {
        final ContractPerson saved = contractPersonDAO.saveAndFlush(contractPerson);
        return modelMapper.map(saved, ContractPersonDTO.Info.class);
    }
}
