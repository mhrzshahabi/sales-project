package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.contract.IContractService2;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.model.entities.contract.*;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContractService2 extends GenericService<Contract2, Long, ContractDTO2.Create, ContractDTO2.Info, ContractDTO2.Update, ContractDTO2.Delete> implements IContractService2 {

    @Override
    @Transactional
    @Action(ActionType.Create)
    @Override
    @Transactional
    @Action(ActionType.Create)
    public ContractDTO2.Info create(ContractDTO2.Create request) {

        final Contract2 contract2 = modelMapper.map(request, Contract2.class);
        validation(contract2,request);

        contract2.setContractContacts(null);
        contract2.setContractDetails(null);

        ContractDTO2.Info savedContract2 = save(contract2);
        if(request.getContractContacts() != null && request.getContractContacts().size() > 0){
            new TypeToken<List<ContractContact>>()
            modelMapper.map(request.getContractContacts(),);
        }
        if(request.getContractDetails() != null && request.getContractDetails().size() > 0){}

        final ContractDetailType contractDetailType = modelMapper.map(request, ContractDetailType.class);
        validation(contractDetailType, request);

        contractDetailType.setContractDetailTypeParams(null);
        contractDetailType.setContractDetailTypeTemplates(null);

        ContractDetailTypeDTO.Info savedContractDetailType = save(contractDetailType);

        if (request.getContractDetailTypeParams() != null && request.getContractDetailTypeParams().size() > 0) {

            final List<ContractDetailTypeParamDTO.Create> contractDetailTypeParamRqs = modelMapper.map(request.getContractDetailTypeParams(),
                    new TypeToken<List<ContractDetailTypeParamDTO.Create>>() {
                    }.getType());
            contractDetailTypeParamRqs.forEach(q -> q.setContractDetailTypeId(savedContractDetailType.getId()));
            List<ContractDetailTypeParamDTO.Info> savedContractDetailTypeParam = contractDetailTypeParamService.createAll(contractDetailTypeParamRqs);
            savedContractDetailType.setContractDetailTypeParams(savedContractDetailTypeParam);
        }

        if (request.getContractDetailTypeTemplates() != null && request.getContractDetailTypeTemplates().size() > 0) {

            final List<ContractDetailTypeTemplateDTO.Create> contractDetailTypeTemplateRqs = modelMapper.map(request.getContractDetailTypeTemplates(),
                    new TypeToken<List<ContractDetailTypeTemplateDTO.Create>>() {
                    }.getType());
            contractDetailTypeTemplateRqs.forEach(q -> q.setContractDetailTypeId(savedContractDetailType.getId()));
            List<ContractDetailTypeTemplateDTO.Info> savedContractDetailTypeTemplates = contractDetailTypeTemplateService.createAll(contractDetailTypeTemplateRqs);
            savedContractDetailType.setContractDetailTypeTemplates(savedContractDetailTypeTemplates);
        }

        return savedContractDetailType;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ContractDetailTypeDTO.Info update(Long id, ContractDetailTypeDTO.Update request) {

        ContractDetailType contractDetailType = repository.findById(id).orElseThrow(() -> new NotFoundException(ContractDetailType.class));

        try {
            updateTemplates(request, contractDetailType);
            updateParams(request, contractDetailType);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail-type.exception.update", null, locale));
        }

        ContractDetailType updating = new ContractDetailType();
        modelMapper.map(contractDetailType, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        updating.setContractDetailTypeParams(null);
        updating.setContractDetailTypeTemplates(null);

        return save(updating);
    }

    @Override
    @Transactional
    @Action(ActionType.Delete)
    public void delete(Long id) {

        ContractDetailType contractDetailType = repository.findById(id).orElseThrow(() -> new NotFoundException(ContractDetailType.class));

        List<ContractDetailTypeParam> contractDetailTypeParams = contractDetailType.getContractDetailTypeParams();
        ContractDetailTypeParamDTO.Delete paramDeleteRq = new ContractDetailTypeParamDTO.Delete();
        paramDeleteRq.setIds(contractDetailTypeParams.stream().map(ContractDetailTypeParam::getId).collect(Collectors.toList()));
        if (!paramDeleteRq.getIds().isEmpty())
            contractDetailTypeParamService.deleteAll(paramDeleteRq);

        ContractDetailTypeTemplateDTO.Delete templateDeleteRq = new ContractDetailTypeTemplateDTO.Delete();
        List<ContractDetailTypeTemplate> contractDetailTypeTemplates = contractDetailType.getContractDetailTypeTemplates();
        templateDeleteRq.setIds(contractDetailTypeTemplates.stream().map(ContractDetailTypeTemplate::getId).collect(Collectors.toList()));
        if (!templateDeleteRq.getIds().isEmpty())
            contractDetailTypeTemplateService.deleteAll(templateDeleteRq);

        validation(contractDetailType, id);

        contractDetailType.setContractDetailTypeParams(null);
        contractDetailType.setContractDetailTypeTemplates(null);

        repository.delete(contractDetailType);
    }

}
