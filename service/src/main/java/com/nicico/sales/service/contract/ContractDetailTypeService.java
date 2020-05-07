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
    @Action(ActionType.Create)
    public ContractDetailTypeDTO.Info create(ContractDetailTypeDTO.Create request) {

        final ContractDetailType contractDetailType = modelMapper.map(request, ContractDetailType.class);
        validation(contractDetailType, request);
        ContractDetailTypeDTO.Info savedContractDetailType = save(contractDetailType);

        if (request.getContractDetailTypeTemplates() != null && request.getContractDetailTypeTemplates().size() > 0) {

            final List<ContractDetailTypeTemplateDTO.Create> contractDetailTypeTemplateRqs = modelMapper.map(request.getContractDetailTypeTemplates(),
                    new TypeToken<List<ContractDetailTypeTemplateDTO.Create>>() {
                    }.getType());
            contractDetailTypeTemplateRqs.forEach(q -> q.setContractDetailTypeId(savedContractDetailType.getId()));
            List<ContractDetailTypeTemplateDTO.Info> savedContractDetailTypeTemplates = contractDetailTypeTemplateService.createAll(contractDetailTypeTemplateRqs);
            savedContractDetailType.setContractDetailTypeTemplates(savedContractDetailTypeTemplates);
        }

        if (request.getContractDetailTypeParams() != null && request.getContractDetailTypeParams().size() > 0) {

            final List<ContractDetailTypeParamDTO.Create> contractDetailTypeParamRqs = modelMapper.map(request.getContractDetailTypeParams(),
                    new TypeToken<List<ContractDetailTypeParamDTO.Create>>() {
                    }.getType());
            List<ContractDetailTypeParamDTO.Info> savedContractDetailTypeParams = new ArrayList<>();
            contractDetailTypeParamRqs.forEach(q -> {

                q.setContractDetailTypeId(savedContractDetailType.getId());
                ContractDetailTypeParamDTO.Info savedContractDetailTypeParam = contractDetailTypeParamService.create(q);

                if (q.getContractDetailTypeParamValues() != null && q.getContractDetailTypeParamValues().size() > 0) {

                    final List<ContractDetailTypeParamValueDTO.Create> contractDetailTypeParamValueRqs = modelMapper.map(q.getContractDetailTypeParamValues(),
                            new TypeToken<List<ContractDetailTypeParamValueDTO.Create>>() {
                            }.getType());
                    contractDetailTypeParamValueRqs.forEach(p -> p.setContractDetailTypeParamId(savedContractDetailTypeParam.getId()));
                    List<ContractDetailTypeParamValueDTO.Info> savedContractDetailTypeParamValues = contractDetailTypeParamValueService.createAll(contractDetailTypeParamValueRqs);
                    savedContractDetailTypeParam.setContractDetailTypeParamValues(savedContractDetailTypeParamValues);
                }

                savedContractDetailTypeParams.add(savedContractDetailTypeParam);
            });
            savedContractDetailType.setContractDetailTypeParams(savedContractDetailTypeParams);
        }

        return savedContractDetailType;
    }

    @Override
    @Transactional
    @Action(ActionType.Update)
    public ContractDetailTypeDTO.Info update(Long aLong, ContractDetailTypeDTO.Update request) {


        throw new RuntimeException();
    }

    @Override
    @Transactional
    @Action(ActionType.Delete)
    public void delete(Long aLong) {


    }
}