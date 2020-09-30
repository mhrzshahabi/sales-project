package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IContractDetailTypeTemplateService;
import com.nicico.sales.model.entities.contract.ContractDetailTypeTemplate;
import com.nicico.sales.repository.contract.ContractDetailTypeTemplateDAO;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeTemplateService extends GenericService<ContractDetailTypeTemplate, Long, ContractDetailTypeTemplateDTO.Create, ContractDetailTypeTemplateDTO.Info, ContractDetailTypeTemplateDTO.Update, ContractDetailTypeTemplateDTO.Delete> implements IContractDetailTypeTemplateService {

    private final ContractDetailTypeTemplateDAO contractDetailTypeTemplateDAO;
    private final ModelMapper modelMapper;

    @Override
    @Action(value = ActionType.Get)
    @Transactional(readOnly = true)
    public List<ContractDetailTypeTemplateDTO.Info> findByContractDetailType(Long id) {
        final List<ContractDetailTypeTemplate> slById = contractDetailTypeTemplateDAO.findByContractDetailTypeId(id);
        return modelMapper.map(slById, new TypeToken<List<ContractDetailTypeTemplateDTO.Info>>() {
        }.getType());
    }

}