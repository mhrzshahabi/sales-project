package com.nicico.sales.service.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractContactDTO;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.dto.contract.ContractDetailDTO2;
import com.nicico.sales.dto.contract.ContractDetailValueDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.contract.IContractContactService;
import com.nicico.sales.iservice.contract.IContractDetailService2;
import com.nicico.sales.iservice.contract.IContractDetailValueService;
import com.nicico.sales.iservice.contract.IContractService2;
import com.nicico.sales.model.entities.contract.Contract2;
import com.nicico.sales.model.entities.contract.ContractDetail2;
import com.nicico.sales.model.enumeration.CommercialRole;
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

@Service
@RequiredArgsConstructor
public class ContractService2 extends GenericService<Contract2, Long, ContractDTO2.Create, ContractDTO2.Info, ContractDTO2.Update, ContractDTO2.Delete> implements IContractService2 {

    private final IContractContactService contractContactService;
    private final IContractDetailService2 contractDetailService;
    private final IContractDetailValueService contractDetailValueService;
    private final UpdateUtil updateUtil;
    private final ResourceBundleMessageSource messageSource;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ContractDTO2.Info create(ContractDTO2.Create request) {

        final Contract2 contract2 = modelMapper.map(request, Contract2.class);
        validation(contract2, request);

        contract2.setContractContacts(null);
        contract2.setContractDetails(null);

        ContractDTO2.Info savedContract2 = save(contract2);

        createContractContacts(savedContract2.getId(), request.getBuyerId(), CommercialRole.Buyer);
        createContractContacts(savedContract2.getId(), request.getSellerId(), CommercialRole.Seller);
        if (request.getAgentBuyerId() != null)
            createContractContacts(savedContract2.getId(), request.getAgentBuyerId(), CommercialRole.AgentBuyer);
        if (request.getAgentSellerId() != null)
            createContractContacts(savedContract2.getId(), request.getAgentSellerId(), CommercialRole.AgentSeller);

        savedContract2.setBuyerId(request.getBuyerId());
        savedContract2.setSellerId(request.getSellerId());
        savedContract2.setAgentBuyerId(request.getAgentBuyerId());
        savedContract2.setAgentSellerId(request.getAgentSellerId());

        if (request.getContractDetails() != null && request.getContractDetails().size() > 0) {
            final List<ContractDetailDTO2.Create> contractDetailsRqs = modelMapper.map(request.getContractDetails(), new TypeToken<List<ContractDetailDTO2.Create>>() {
            }.getType());
            contractDetailsRqs.forEach(q -> {
                List<ContractDetailValueDTO.Create> contractDetailValues = q.getContractDetailValues();
                q.setContractDetailValues(null); //don't want to use CascadeType.ALL
                q.setContractId(savedContract2.getId());
                ContractDetailDTO2.Info savedContractDetail = contractDetailService.create(q);

                if (contractDetailValues != null && contractDetailValues.size() > 0) {
                    List<ContractDetailValueDTO.Create> contractDetailValueRqs = modelMapper.map(contractDetailValues, new TypeToken<List<ContractDetailValueDTO.Create>>() {
                    }.getType());
                    contractDetailValueRqs.forEach(x -> {
                        x.setContractDetailId(savedContractDetail.getId());
                        contractDetailValueService.create(x);
                    });
                }

            });
        }

        return savedContract2;
    }

    private void createContractContacts(Long contractId, Long contactId, CommercialRole commercialRole) {
        ContractContactDTO.Create contractContactDTO = new ContractContactDTO.Create();
        contractContactDTO.setContractId(contractId);
        contractContactDTO.setContactId(contactId);
        contractContactDTO.setCommercialRole(commercialRole);
        contractContactService.create(contractContactDTO);
    }

    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public TotalResponse<ContractDTO2.Info> search(NICICOCriteria request) {

        List<Contract2> entities = new ArrayList<>();
        TotalResponse<ContractDTO2.Info> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ContractDTO2.Info eResult = modelMapper.map(entity, ContractDTO2.Info.class);
            validation(entity, eResult);
            entities.add(entity);
            eResult.getContractContacts().forEach(q -> {
                if (q.getCommercialRole() == CommercialRole.Buyer)
                    eResult.setBuyerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.Seller)
                    eResult.setSellerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.AgentBuyer)
                    eResult.setAgentBuyerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.AgentSeller)
                    eResult.setAgentSellerId(q.getContactId());
            });
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ContractDTO2.Info update(Long id, ContractDTO2.Update request) {

        Contract2 contract2 = repository.findById(id).orElseThrow(() -> new NotFoundException(Contract2.class));

        // update ContractContacts
        request.getContractContacts().forEach(q -> {
            if (q.getCommercialRole() == CommercialRole.Buyer)
                q.setContactId(request.getBuyerId());
            if (q.getCommercialRole() == CommercialRole.Seller)
                q.setContactId(request.getSellerId());
            if (q.getCommercialRole() == CommercialRole.AgentBuyer)
                q.setContactId(request.getAgentBuyerId());
            if (q.getCommercialRole() == CommercialRole.AgentSeller)
                q.setContactId(request.getAgentSellerId());
            contractContactService.update(modelMapper.map(q, ContractContactDTO.Update.class));
        });

        //  update ContractDetails
        List<ContractDetailDTO2.Create> contractDetail4Insert = new ArrayList<>();
        List<ContractDetailDTO2.Update> contractDetail4Update = new ArrayList<>();
        ContractDetailDTO2.Delete contractDetail4Delete = new ContractDetailDTO2.Delete();

        try {
            updateUtil.fill(ContractDetail2.class, contract2.getContractDetails(),
                    ContractDetailDTO2.Info.class, request.getContractDetails(),
                    ContractDetailDTO2.Create.class, contractDetail4Insert,
                    ContractDetailDTO2.Update.class, contractDetail4Update,
                    contractDetail4Delete);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {
            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail.exception.update", null, locale));
        }

        if (!contractDetail4Insert.isEmpty()) {
            contractDetail4Insert.forEach(q -> q.setContractId(contract2.getId()));
            contractDetailService.createAll(contractDetail4Insert);
        }
        //because ContractDetail to ContractDetailValue : CascadeType.ALL
        if (!contractDetail4Update.isEmpty()) {
            contractDetail4Update.forEach(q -> q.setContractId(contract2.getId()));
            contractDetailService.updateAll(contractDetail4Update);
        }
        if (!contractDetail4Delete.getIds().isEmpty())
            contractDetailService.deleteAll(contractDetail4Delete);

        Contract2 updating = new Contract2();

        contract2.setContractDetails(null);
        request.setContractDetails(null);

        modelMapper.map(contract2, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        updating.setContractContacts(null);

        return save(updating);
    }

}
