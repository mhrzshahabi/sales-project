package com.nicico.sales.service.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.contract.ContractContactDTO;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.dto.contract.ContractDetailDTO2;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.contract.IContractContactService;
import com.nicico.sales.iservice.contract.IContractDetailService2;
import com.nicico.sales.iservice.contract.IContractService2;
import com.nicico.sales.model.entities.contract.Contract2;
import com.nicico.sales.model.enumeration.CommercialRole;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.utility.UpdateUtil;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContractService2 extends GenericService<Contract2, Long, ContractDTO2.Create, ContractDTO2.Info, ContractDTO2.Update, ContractDTO2.Delete> implements IContractService2 {

    private final IContractContactService contractContactService;
    private final IContractDetailService2 contractDetailService;
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
        createContractContacts(savedContract2.getId(), request.getAgentBuyerId(), CommercialRole.AgentBuyer);
        createContractContacts(savedContract2.getId(), request.getAgentSellerId(), CommercialRole.AgentSeller);

        savedContract2.setBuyerId(request.getBuyerId());
        savedContract2.setSellerId(request.getSellerId());
        savedContract2.setAgentBuyerId(request.getAgentBuyerId());
        savedContract2.setAgentSellerId(request.getAgentSellerId());

        if (request.getContractDetails() != null && request.getContractDetails().size() > 0) {
            final List<ContractDetailDTO2.Create> contractDetailsRqs = modelMapper.map(request.getContractDetails(), new TypeToken<List<ContractDetailDTO2.Create>>() {
            }.getType());
            contractDetailsRqs.forEach(q -> {
                q.setContractId(savedContract2.getId());
                contractDetailService.create(q);
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

        // update ContractDetails
//        try {
        updateDetails(request, contract2);
//        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {
//
//            Locale locale = LocaleContextHolder.getLocale();
//            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail.exception.update", null, locale));
//        }

        Contract2 updating = new Contract2();
        modelMapper.map(contract2, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        updating.setContractContacts(null);
        updating.setContractDetails(null);

        return save(updating);
    }

    private void updateDetails(ContractDTO2.Update request, Contract2 contract2) {

        List<ContractDetailDTO2.Create> contractDetail4Insert = modelMapper.map(request.getContractDetails().stream().filter(req ->
                contract2.getContractDetails().stream().noneMatch(db -> db.getContractDetailTypeId().equals(req.getContractDetailTypeId())))
                .collect(Collectors.toList()), new TypeToken<List<ContractDetailDTO2.Create>>() {
        }.getType());

        ContractDetailDTO2.Delete contractDetail4Delete = new ContractDetailDTO2.Delete();
        contractDetail4Delete.setIds(modelMapper.map(contract2.getContractDetails().stream().filter(db ->
                request.getContractDetails().stream().noneMatch(req -> req.getContractDetailTypeId().equals(db.getContractDetailTypeId())))
                .collect(Collectors.toList()), new TypeToken<List<ContractDetailDTO2.Create>>() {
        }.getType()));

        System.out.println("");
        if (!contractDetail4Insert.isEmpty())
            contractDetailService.createAll(contractDetail4Insert);
        if (!contractDetail4Delete.getIds().isEmpty())
            contractDetailService.deleteAll(contractDetail4Delete);
    }

}
