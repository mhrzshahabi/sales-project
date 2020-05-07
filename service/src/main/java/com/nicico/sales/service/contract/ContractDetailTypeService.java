package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamValueDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamService;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamValueService;
import com.nicico.sales.iservice.contract.IContractDetailTypeService;
import com.nicico.sales.iservice.contract.IContractDetailTypeTemplateService;
import com.nicico.sales.model.entities.contract.ContractDetailType;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeService extends GenericService<ContractDetailType, Long, ContractDetailTypeDTO.Create, ContractDetailTypeDTO.Info, ContractDetailTypeDTO.Update, ContractDetailTypeDTO.Delete> implements IContractDetailTypeService {

    private final IContractDetailTypeParamService contractDetailTypeParamService;
    private final IContractDetailTypeTemplateService contractDetailTypeTemplateService;
    private final IContractDetailTypeParamValueService contractDetailTypeParamValueService;

    @Override
    @Transactional
    @Action(value = ActionType.Create)
    public ContractDetailTypeDTO.Info create(ContractDetailTypeDTO.Create request) {

        final ContractDetailType contractDetailType = modelMapper.map(request, ContractDetailType.class);
        validation(contractDetailType, request);
        ContractDetailTypeDTO.Info savedContractDetailType = save(contractDetailType);

        if (request.getTemplates() != null && request.getTemplates().size() > 0) {

            final List<ContractDetailTypeTemplateDTO.Create> contractDetailTypeTemplateRqs = modelMapper.map(request.getTemplates(),
                    new TypeToken<List<ContractDetailTypeTemplateDTO.Create>>() {
                    }.getType());
            contractDetailTypeTemplateRqs.forEach(q -> q.setContractDetailTypeId(savedContractDetailType.getId()));
            List<ContractDetailTypeTemplateDTO.Info> savedContractDetailTypeTemplates = contractDetailTypeTemplateService.createAll(contractDetailTypeTemplateRqs);
            savedContractDetailType.setTemplates(savedContractDetailTypeTemplates);
        }

        if (request.getParams() != null && request.getParams().size() > 0) {

            final List<ContractDetailTypeParamDTO.Create> contractDetailTypeParamRqs = modelMapper.map(request.getParams(),
                    new TypeToken<List<ContractDetailTypeParamDTO.Create>>() {
                    }.getType());
            List<ContractDetailTypeParamDTO.Info> savedContractDetailTypeParams = new ArrayList<>();
            contractDetailTypeParamRqs.forEach(q -> {

                q.setContractDetailTypeId(savedContractDetailType.getId());
                ContractDetailTypeParamDTO.Info savedContractDetailTypeParam = contractDetailTypeParamService.create(q);

                if (q.getValues() != null && q.getValues().size() > 0) {

                    final List<ContractDetailTypeParamValueDTO.Create> contractDetailTypeParamValueRqs = modelMapper.map(q.getValues(),
                            new TypeToken<List<ContractDetailTypeParamValueDTO.Create>>() {
                            }.getType());
                    contractDetailTypeParamValueRqs.forEach(p -> p.setContractDetailTypeParamId(savedContractDetailTypeParam.getId()));
                    List<ContractDetailTypeParamValueDTO.Info> savedContractDetailTypeParamValues = contractDetailTypeParamValueService.createAll(contractDetailTypeParamValueRqs);
                    savedContractDetailTypeParam.setValues(savedContractDetailTypeParamValues);
                }

                savedContractDetailTypeParams.add(savedContractDetailTypeParam);
            });
            savedContractDetailType.setParams(savedContractDetailTypeParams);
        }

        return savedContractDetailType;
    }

    @Override
    public ContractDetailTypeDTO.Info update(Long aLong, ContractDetailTypeDTO.Update request) {


        throw new RuntimeException();
    }
}