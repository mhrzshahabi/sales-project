package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamValueDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamService;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamValueService;
import com.nicico.sales.iservice.contract.IContractDetailTypeService;
import com.nicico.sales.iservice.contract.IContractDetailTypeTemplateService;
import com.nicico.sales.model.entities.contract.ContractDetailType;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParamValue;
import com.nicico.sales.model.entities.contract.ContractDetailTypeTemplate;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.utility.UpdateUtil;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeService extends GenericService<ContractDetailType, Long, ContractDetailTypeDTO.Create, ContractDetailTypeDTO.Info, ContractDetailTypeDTO.Update, ContractDetailTypeDTO.Delete> implements IContractDetailTypeService {

    private final UpdateUtil updateUtil;
    private final ResourceBundleMessageSource messageSource;
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
//            savedContractDetailType.setContractDetailTypeTemplates(savedContractDetailTypeTemplates);
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
//                    savedContractDetailTypeParam.setContractDetailTypeParamValues(savedContractDetailTypeParamValues);
                }

                savedContractDetailTypeParams.add(savedContractDetailTypeParam);
            });
//            savedContractDetailType.setContractDetailTypeParams(savedContractDetailTypeParams);
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
            updateParamsAndValues(request, contractDetailType);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail-type.exception.update", null, locale));
        }

        ContractDetailType updating = new ContractDetailType();
        modelMapper.map(contractDetailType, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        return save(updating);
    }

    @Override
    @Transactional
    @Action(ActionType.Delete)
    public void delete(Long id) {

        ContractDetailType contractDetailType = repository.findById(id).orElseThrow(() -> new NotFoundException(ContractDetailType.class));

        ContractDetailTypeParamValueDTO.Delete paramValueDeleteRq = new ContractDetailTypeParamValueDTO.Delete();
        paramValueDeleteRq.setIds(new ArrayList<>());
        List<ContractDetailTypeParam> contractDetailTypeParams = contractDetailType.getContractDetailTypeParams();
        for (ContractDetailTypeParam q : contractDetailTypeParams)
            paramValueDeleteRq.getIds().addAll(q.getContractDetailTypeParamValues().stream().map(ContractDetailTypeParamValue::getId).collect(Collectors.toList()));

        if (!paramValueDeleteRq.getIds().isEmpty())
            contractDetailTypeParamValueService.deleteAll(paramValueDeleteRq);

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
        repository.delete(contractDetailType);
    }

    private void updateTemplates(ContractDetailTypeDTO.Update request, ContractDetailType contractDetailType) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<ContractDetailTypeTemplateDTO.Create> contractDetailTypeTemplates4Insert = new ArrayList<>();
        List<ContractDetailTypeTemplateDTO.Update> contractDetailTypeTemplates4Update = new ArrayList<>();
        ContractDetailTypeTemplateDTO.Delete contractDetailTypeTemplates4Delete = new ContractDetailTypeTemplateDTO.Delete();
        /*updateUtil.fill(
                ContractDetailTypeTemplate.class,
                contractDetailType.getContractDetailTypeTemplates(),
                ContractDetailTypeTemplateDTO.Info.class,
                request.getContractDetailTypeTemplates(),
                ContractDetailTypeTemplateDTO.Create.class,
                contractDetailTypeTemplates4Insert,
                ContractDetailTypeTemplateDTO.Update.class,
                contractDetailTypeTemplates4Update,
                contractDetailTypeTemplates4Delete);*/
        if (!contractDetailTypeTemplates4Insert.isEmpty())
            contractDetailTypeTemplateService.createAll(contractDetailTypeTemplates4Insert);
        if (!contractDetailTypeTemplates4Update.isEmpty())
            contractDetailTypeTemplateService.updateAll(contractDetailTypeTemplates4Update);
        if (!contractDetailTypeTemplates4Delete.getIds().isEmpty())
            contractDetailTypeTemplateService.deleteAll(contractDetailTypeTemplates4Delete);
    }

    private void updateParamsAndValues(ContractDetailTypeDTO.Update request, ContractDetailType contractDetailType) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<ContractDetailTypeParamDTO.Create> contractDetailTypeParams4Insert = new ArrayList<>();
        List<ContractDetailTypeParamDTO.Update> contractDetailTypeParams4Update = new ArrayList<>();
        ContractDetailTypeParamDTO.Delete contractDetailTypeParams4Delete = new ContractDetailTypeParamDTO.Delete();
        /*updateUtil.fill(
                ContractDetailTypeParam.class,
                contractDetailType.getContractDetailTypeParams(),
                ContractDetailTypeParamDTO.Info.class,
                request.getContractDetailTypeParams(),
                ContractDetailTypeParamDTO.Create.class,
                contractDetailTypeParams4Insert,
                ContractDetailTypeParamDTO.Update.class,
                contractDetailTypeParams4Update,
                contractDetailTypeParams4Delete);*/
        if (!contractDetailTypeParams4Insert.isEmpty()) {

            contractDetailTypeParams4Insert.forEach(q -> {

                /*ContractDetailTypeParamDTO.Info savedContractDetailTypeParam = contractDetailTypeParamService.create(q);
                List<ContractDetailTypeParamValueDTO.Info> contractDetailTypeParamValues = q.getContractDetailTypeParamValues();
                if (contractDetailTypeParamValues != null && contractDetailTypeParamValues.size() > 0) {

                    contractDetailTypeParamValues.forEach(p -> p.setContractDetailTypeParamId(savedContractDetailTypeParam.getId()));
                    contractDetailTypeParamValueService.createAll(modelMapper.map(
                            contractDetailTypeParamValues,
                            new TypeToken<List<ContractDetailTypeParamValueDTO.Create>>() {
                            }.getType()));
                }*/
            });
        }
        if (!contractDetailTypeParams4Update.isEmpty()) {

            for (ContractDetailTypeParamDTO.Update q : contractDetailTypeParams4Update) {

                contractDetailTypeParamService.update(q);

                List<ContractDetailTypeParamValueDTO.Create> contractDetailTypeParamValues4Insert = new ArrayList<>();
                List<ContractDetailTypeParamValueDTO.Update> contractDetailTypeParamValues4Update = new ArrayList<>();
                ContractDetailTypeParamValueDTO.Delete contractDetailTypeParamValues4Delete = new ContractDetailTypeParamValueDTO.Delete();
                /*updateUtil.fill(
                        ContractDetailTypeParamValue.class,
                        contractDetailType.getContractDetailTypeParams().
                                stream().
                                filter(p -> p.getId().longValue() == q.getId()).
                                findFirst().get().getContractDetailTypeParamValues(),
                        ContractDetailTypeParamValueDTO.Info.class,
                        request.getContractDetailTypeParams().
                                stream().
                                filter(p -> p.getId().longValue() == q.getId()).
                                findFirst().get().getContractDetailTypeParamValues(),
                        ContractDetailTypeParamValueDTO.Create.class,
                        contractDetailTypeParamValues4Insert,
                        ContractDetailTypeParamValueDTO.Update.class,
                        contractDetailTypeParamValues4Update,
                        contractDetailTypeParamValues4Delete);*/
                if (!contractDetailTypeParamValues4Insert.isEmpty())
                    contractDetailTypeParamValueService.createAll(contractDetailTypeParamValues4Insert);
                if (!contractDetailTypeParamValues4Update.isEmpty())
                    contractDetailTypeParamValueService.updateAll(contractDetailTypeParamValues4Update);
                if (!contractDetailTypeParamValues4Delete.getIds().isEmpty())
                    contractDetailTypeParamValueService.deleteAll(contractDetailTypeParamValues4Delete);
            }
        }
        if (!contractDetailTypeParams4Delete.getIds().isEmpty()) {

            ContractDetailTypeParamValueDTO.Delete contractDetailTypeParamValues4Delete = new ContractDetailTypeParamValueDTO.Delete();
            contractDetailTypeParamValues4Delete.setIds(contractDetailType.getContractDetailTypeParams().
                    stream().
                    filter(q -> contractDetailTypeParams4Delete.getIds().stream().anyMatch(p -> p.longValue() == q.getId())).
                    flatMap(q -> q.getContractDetailTypeParamValues().stream()).
                    map(ContractDetailTypeParamValue::getId).
                    collect(Collectors.toList()));

            if (!contractDetailTypeParamValues4Delete.getIds().isEmpty())
                contractDetailTypeParamValueService.deleteAll(contractDetailTypeParamValues4Delete);
            contractDetailTypeParamService.deleteAll(contractDetailTypeParams4Delete);
        }
    }
}