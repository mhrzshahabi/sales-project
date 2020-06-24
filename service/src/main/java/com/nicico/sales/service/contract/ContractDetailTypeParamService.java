package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamService;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;
import com.nicico.sales.repository.contract.ContractDetailTypeParamDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeParamService extends GenericService<ContractDetailTypeParam, Long, ContractDetailTypeParamDTO.Create, ContractDetailTypeParamDTO.Info, ContractDetailTypeParamDTO.Update, ContractDetailTypeParamDTO.Delete> implements IContractDetailTypeParamService {

    private final ContractDetailTypeParamDAO contractDetailTypeParamDAO;
    private final ModelMapper modelMapper;

    @Override
    public List<ContractDetailTypeParamDTO.Info> findByContractDetailType(Long id) {
        final List<ContractDetailTypeParam> slById = contractDetailTypeParamDAO.findByContractDetailTypeId(id);
        return modelMapper.map(slById, new TypeToken<List<ContractDetailTypeParamDTO.Info>>() {
        }.getType());
    }
}