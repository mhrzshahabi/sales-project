package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractContactDTO;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.contract.IContractContactService;
import com.nicico.sales.iservice.contract.IContractService2;
import com.nicico.sales.model.entities.contract.Contract2;
import com.nicico.sales.model.entities.contract.ContractContact;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContractService2 extends GenericService<Contract2, Long, ContractDTO2.Create, ContractDTO2.Info, ContractDTO2.Update, ContractDTO2.Delete> implements IContractService2 {

    private final IContractContactService contractContactService;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ContractDTO2.Info create(ContractDTO2.Create request) {

        final Contract2 contract2 = modelMapper.map(request, Contract2.class);
        validation(contract2, request);

        contract2.setContractContacts(null);
        contract2.setContractDetails(null);

        ContractDTO2.Info savedContract2 = save(contract2);
        if (request.getContractContacts() != null && request.getContractContacts().size() > 0) {
            final List<ContractContactDTO.Create> contractContactsRqs = modelMapper.map(request.getContractContacts(), new TypeToken<List<ContractContactDTO.Create>>() {
            }.getType());
            contractContactsRqs.forEach(q -> q.setContractId(savedContract2.getId()));
            List<ContractContactDTO.Info> savedContractContact = contractContactService.createAll(contractContactsRqs);
            savedContract2.setContractContacts(savedContractContact);
        }
        if (request.getContractDetails() != null && request.getContractDetails().size() > 0) {
        }

        return savedContract2;
    }

    /*@Override
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
    }*/

}
