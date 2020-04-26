package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.iservice.contract.IContractDetailTypeTemplateService;
import com.nicico.sales.model.entities.contract.ContractDetailTypeTemplate;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeTemplateService extends GenericService<ContractDetailTypeTemplate, Long, ContractDetailTypeTemplateDTO.Create, ContractDetailTypeTemplateDTO.Info, ContractDetailTypeTemplateDTO.Update, ContractDetailTypeTemplateDTO.Delete> implements IContractDetailTypeTemplateService {
}