package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContractDetailDTO;
import com.nicico.sales.iservice.IContractDetailService;
import com.nicico.sales.model.entities.base.ContractDetail;
import com.nicico.sales.repository.ContractDetailDAO;
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
public class ContractDetailService implements IContractDetailService {

    private final ContractDetailDAO contractDetailDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_CONTRACT_DETAIL')")
    public ContractDetailDTO.Info get(Long id) {
        final Optional<ContractDetail> slById = contractDetailDAO.findById(id);
        final ContractDetail contractDetail = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractDetailNotFound));

        return modelMapper.map(contractDetail, ContractDetailDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_DETAIL')")
    public List<ContractDetailDTO.Info> list() {
        final List<ContractDetail> slAll = contractDetailDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContractDetailDTO.Info>>() {
        }.getType());
    }

    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_DETAIL')")
    public ContractDetailDTO FindByContractID(Long id) {
        ContractDetail byContract_id = contractDetailDAO.findByContract_id(id);
        return modelMapper.map(byContract_id, ContractDetailDTO.class);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_CONTRACT_DETAIL')")
    public ContractDetailDTO.Info create(ContractDetailDTO.Create request) {
        final ContractDetail contractDetail = modelMapper.map(request, ContractDetail.class);
        return save(contractDetail);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_CONTRACT_DETAIL')")
    public ContractDetailDTO.Info update(Long id, ContractDetailDTO.Update request) {
        final Optional<ContractDetail> slById = contractDetailDAO.findById(id);
        final ContractDetail contractDetail = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContractDetailNotFound));

        ContractDetail updating = new ContractDetail();
        modelMapper.map(contractDetail, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTRACT_DETAIL')")
    public void delete(Long id) {
        contractDetailDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTRACT_DETAIL')")
    public void delete(ContractDetailDTO.Delete request) {
        final List<ContractDetail> contractDetails = contractDetailDAO.findAllById(request.getIds());

        contractDetailDAO.deleteAll(contractDetails);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTRACT_DETAIL')")
    public TotalResponse<ContractDetailDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(contractDetailDAO, criteria, contractDetail -> modelMapper.map(contractDetail, ContractDetailDTO.Info.class));
    }

    private ContractDetailDTO.Info save(ContractDetail contractDetail) {
        final ContractDetail saved = contractDetailDAO.saveAndFlush(contractDetail);
        return modelMapper.map(saved, ContractDetailDTO.Info.class);
    }
}
