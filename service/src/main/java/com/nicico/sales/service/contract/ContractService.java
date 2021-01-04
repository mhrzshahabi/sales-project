package com.nicico.sales.service.contract;

import com.google.common.base.Enums;
import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.annotation.CheckCriteria;
import com.nicico.sales.dto.contract.*;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.contract.*;
import com.nicico.sales.model.entities.common.BaseEntity;
import com.nicico.sales.model.entities.contract.*;
import com.nicico.sales.model.enumeration.CommercialRole;
import com.nicico.sales.model.enumeration.ContractDetailTypeReference;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.repository.contract.*;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.utility.EntityRelationChecker;
import com.nicico.sales.utility.StringFormatUtil;
import com.nicico.sales.utility.UpdateUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ContractService extends GenericService<Contract, Long, ContractDTO.Create, ContractDTO.Info, ContractDTO.Update, ContractDTO.Delete> implements IContractService {

    /******************************************************************************************************************/

    private static final String CONTRACT_DETAIL_EXCEPTION_UPDATE = "contract-detail.exception.update";

    /******************************************************************************************************************/

    private final ContractDetailDAO contractDetailDAO;
    private final ContractContactDAO contractContactDAO;
    private final ContractDetailValueDAO contractDetailValueDAO;
    private final CDTPDynamicTableValueDAO dynamicTableValueDAO;

    /******************************************************************************************************************/

    private final IContractDetailService contractDetailService;
    private final IContractContactService contractContactService;
    private final IContractDetailValueService contractDetailValueService;
    private final ICDTPDynamicTableValueService dynamicTableValueService;

    /******************************************************************************************************************/

    private final IContractDetailValueService2 contractDetailValueService2;

    /******************************************************************************************************************/

    private final IDeductionService deductionService;
    private final ITypicalAssayService typicalAssayService;
    private final IContractDiscountService contractDiscountService;
    private final IContractShipmentService contractShipmentService;

    /******************************************************************************************************************/

    private final Gson gson;
    private final UpdateUtil updateUtil;
    private final EntityRelationChecker relationChecker;
    private final ResourceBundleMessageSource messageSource;

    /******************************************************************************************************************/
    /******************************************************************************************************************/

    private void deleteContractDetailValueExtras(ContractDetailValue contractDetailValue) {

        if (contractDetailValue.getType().name().equals(DataType.ListOfReference.name())) {

            if (ContractDetailTypeReference.ContractShipment.name().equals(contractDetailValue.getReference()))
                contractShipmentService.delete(Long.valueOf(contractDetailValue.getValue()));
            else if (ContractDetailTypeReference.TypicalAssay.name().equals(contractDetailValue.getReference()))
                typicalAssayService.delete(Long.valueOf(contractDetailValue.getValue()));
            else if (ContractDetailTypeReference.Deduction.name().equals(contractDetailValue.getReference()))
                deductionService.delete(Long.valueOf(contractDetailValue.getValue()));
            else if (ContractDetailTypeReference.Discount.name().equals(contractDetailValue.getReference()))
                contractDiscountService.delete(Long.valueOf(contractDetailValue.getValue()));
        }
    }

    /******************************************************************************************************************/

    private Long createDiscount(ContractDetailValueDTO.Create contractDetailValue, Long contractId) {

        ContractDiscountDTO.Create contractDiscountDto = gson.fromJson(contractDetailValue.getReferenceJsonValue(), ContractDiscountDTO.Create.class);
        contractDiscountDto.setContractId(contractId);

        return contractDiscountService.create(contractDiscountDto).getId();
    }

    private Long createDeduction(ContractDetailValueDTO.Create contractDetailValue, Long contractId) {

        DeductionDTO.Create deductionDTO = gson.fromJson(contractDetailValue.getReferenceJsonValue(), DeductionDTO.Create.class);
        deductionDTO.setContractId(contractId);

        return deductionService.create(deductionDTO).getId();
    }

    private Long createTypicalAssay(ContractDetailValueDTO.Create contractDetailValue, Long contractId) {

        TypicalAssayDTO.Create typicalAssayDTO = gson.fromJson(contractDetailValue.getReferenceJsonValue(), TypicalAssayDTO.Create.class);
        typicalAssayDTO.setContractId(contractId);

        return typicalAssayService.create(typicalAssayDTO).getId();
    }

    private Long createContractShipment(ContractDetailValueDTO.Create contractDetailValue, Long contractId) {

        ContractShipmentDTO.Create contractShipment = gson.fromJson(contractDetailValue.getReferenceJsonValue(), ContractShipmentDTO.Create.class);
        contractShipment.setContractId(contractId);

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(contractShipment.getSendDate());
        calendar.set(Calendar.HOUR_OF_DAY, 12);
        contractShipment.setSendDate(calendar.getTime());

        return contractShipmentService.create(contractShipment).getId();
    }

    private void createContractContacts(Long contractId, Long contactId, CommercialRole commercialRole) {

        ContractContactDTO.Create contractContact = new ContractContactDTO.Create();
        contractContact.setContactId(contactId);
        contractContact.setContractId(contractId);
        contractContact.setCommercialRole(commercialRole);

        contractContactService.create(contractContact);
    }

    private void createContractDetails(List<ContractDetailDTO.Create> contractDetails, Long contractId) {

        contractDetails.forEach(contractDetail -> {

            contractDetail.setContractId(contractId);
            ContractDetailDTO.Info savedContractDetail = contractDetailService.create(contractDetail);

            contractDetail.getContractDetailValues().forEach(contractDetailValue -> {

                createContractDetailValueExtras(contractDetailValue, contractId);
                contractDetailValue.setContractDetailId(savedContractDetail.getId());
                ContractDetailValueDTO.Info savedContractDetailValue = contractDetailValueService.create(contractDetailValue);

                contractDetailValue.getDynamicTableValues().forEach(dynamicTableValue -> {

                    dynamicTableValue.setContractDetailValueId(savedContractDetailValue.getId());
                    dynamicTableValueService.create(dynamicTableValue);
                });
            });
        });
    }

    private void createContractDetailValueExtras(ContractDetailValueDTO.Create contractDetailValue, Long contractId) {

        if (contractDetailValue.getType().name().equals(DataType.ListOfReference.name())) {

            if (ContractDetailTypeReference.ContractShipment.name().equals(contractDetailValue.getReference()))
                contractDetailValue.setValue(createContractShipment(contractDetailValue, contractId).toString());
            else if (ContractDetailTypeReference.TypicalAssay.name().equals(contractDetailValue.getReference()))
                contractDetailValue.setValue(createTypicalAssay(contractDetailValue, contractId).toString());
            else if (ContractDetailTypeReference.Deduction.name().equals(contractDetailValue.getReference()))
                contractDetailValue.setValue(createDeduction(contractDetailValue, contractId).toString());
            else if (ContractDetailTypeReference.Discount.name().equals(contractDetailValue.getReference()))
                contractDetailValue.setValue(createDiscount(contractDetailValue, contractId).toString());
        }
    }

    private void createContractDetailValues(List<ContractDetailValueDTO.Create> contractDetailValues, Long contractId, Long contractDetailId) {

        contractDetailValues.forEach(contractDetailValue -> {

            createContractDetailValueExtras(contractDetailValue, contractId);
            contractDetailValue.setContractDetailId(contractDetailId);
            ContractDetailValueDTO.Info savedContractDetailValue = contractDetailValueService.create(contractDetailValue);

            contractDetailValue.getDynamicTableValues().forEach(dynamicTableValue -> {

                dynamicTableValue.setContractDetailValueId(savedContractDetailValue.getId());
                dynamicTableValueService.create(dynamicTableValue);
            });
        });
    }

    /******************************************************************************************************************/

    private void updateDiscount(ContractDetailValueDTO.Update contractDetailValue) {
        ContractDiscountDTO.Update contractDiscountDto = gson.fromJson(contractDetailValue.getReferenceJsonValue(), ContractDiscountDTO.Update.class);
        contractDiscountService.update(contractDiscountDto.getId(), contractDiscountDto);
    }

    private void updateDeduction(ContractDetailValueDTO.Update contractDetailValue) {
        DeductionDTO.Update deductionDTO = gson.fromJson(contractDetailValue.getReferenceJsonValue(), DeductionDTO.Update.class);
        deductionService.update(deductionDTO.getId(), deductionDTO);
    }

    private void updateTypicalAssay(ContractDetailValueDTO.Update contractDetailValue) {
        TypicalAssayDTO.Update typicalAssayDTO = gson.fromJson(contractDetailValue.getReferenceJsonValue(), TypicalAssayDTO.Update.class);
        typicalAssayService.update(typicalAssayDTO.getId(), typicalAssayDTO);
    }

    private void updateContractShipment(ContractDetailValueDTO.Update contractDetailValue) {
        ContractShipmentDTO.Update contractShipmentDTO = gson.fromJson(contractDetailValue.getReferenceJsonValue(), ContractShipmentDTO.Update.class);
        contractShipmentService.update(contractShipmentDTO.getId(), contractShipmentDTO);
    }

    private void updateContractContacts(ContractContact savedContractContact, Long contractId, Long newContactId, CommercialRole commercialRole) {

        if (savedContractContact != null) {

            ContractContactDTO.Update contractContactDTO = new ContractContactDTO.Update();
            contractContactDTO.setContactId(newContactId);
            contractContactDTO.setContractId(contractId);
            contractContactDTO.setCommercialRole(commercialRole);
            contractContactDTO.setId(savedContractContact.getId());
            contractContactDTO.setVersion(savedContractContact.getVersion());

            contractContactService.update(contractContactDTO);
        } else
            createContractContacts(contractId, newContactId, commercialRole);
    }

    private void updateContractDetailValueExtras(ContractDetailValueDTO.Update contractDetailValue) {

        if (contractDetailValue.getType().name().equals(DataType.ListOfReference.name())) {

            if (ContractDetailTypeReference.ContractShipment.name().equals(contractDetailValue.getReference()))
                updateContractShipment(contractDetailValue);
            else if (ContractDetailTypeReference.TypicalAssay.name().equals(contractDetailValue.getReference()))
                updateTypicalAssay(contractDetailValue);
            else if (ContractDetailTypeReference.Deduction.name().equals(contractDetailValue.getReference()))
                updateDeduction(contractDetailValue);
            else if (ContractDetailTypeReference.Discount.name().equals(contractDetailValue.getReference()))
                updateDiscount(contractDetailValue);
        }
    }

    /******************************************************************************************************************/

    @Override
    @Transactional(readOnly = true)
    public String getContent(Long id) {

        return ((ContractDAO)repository).getContent(id);
    }

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ContractDTO.Info create(ContractDTO.Create request) {

        ContractDTO.Info savedContract = super.create(request);

        createContractContacts(savedContract.getId(), request.getBuyerId(), CommercialRole.Buyer);
        createContractContacts(savedContract.getId(), request.getSellerId(), CommercialRole.Seller);
        if (request.getAgentBuyerId() != null)
            createContractContacts(savedContract.getId(), request.getAgentBuyerId(), CommercialRole.AgentBuyer);
        if (request.getAgentSellerId() != null)
            createContractContacts(savedContract.getId(), request.getAgentSellerId(), CommercialRole.AgentSeller);

        createContractDetails(request.getContractDetails(), savedContract.getId());

//        ///الحاقیه
//        Set<ContractShipment> contractShipmentsWithShipments = new HashSet<>();
//        if (request.getParentId() != null) {
//            contractShipmentsWithShipments = getContractShipmentsWithShipment(request);
//        }
//        ///الحاقیه آخرش
//        /***شروع الحاقیه***/
//        if (contractShipmentsWithShipments.size() > 0 && requestContractDetails != null) {
//            final Calendar cal = Calendar.getInstance();
//            final Calendar kal = Calendar.getInstance();
//            Set<ContractShipment> contractShipmentsFromAddendum = new HashSet<>(contractShipmentDAO.findByContractId(contract.getId()));
//            if (contractShipmentsFromAddendum.size() > 0 && contractShipmentsWithShipments.size() > 0) {
//                for (ContractShipment csws : contractShipmentsWithShipments) {
//                    cal.setTime(csws.getSendDate());
//                    final Long contractIdMain = csws.getContractId();
//                    final Boolean[] found = {false};
//
//                    for (ContractShipment csfa : contractShipmentsFromAddendum) {
//                        kal.setTime(csfa.getSendDate());
//                        if (found[0]) continue;
//                        final Long addendumId = csfa.getContractId();
//                        if (!addendumId.equals(contractIdMain) && csfa.getLoadPortId().equals(csws.getLoadPortId()) && csfa.getTolerance().equals(csws.getTolerance()) && csfa.getQuantity().equals(csws.getQuantity()) && kal.get(Calendar.YEAR) == cal.get(Calendar.YEAR) && kal.get(Calendar.DAY_OF_YEAR) == cal.get(Calendar.DAY_OF_YEAR)) {
//                            found[0] = true;
//                            if (csfa.getParentId() == null || csfa.getParentId().equals(csws.getParentId()))
//                                csfa.setParentId(csws.getId());
//                            contractShipmentDAO.save(csfa);
//                        }
//                    }
//                    if (!found[0]) throw new SalesException2(ErrorType.NotFound);
//                }
//
//            }
//        }
//
//        /***پایان الحاقیه***/

        return savedContract;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ContractDTO.Info update(Long id, ContractDTO.Update request) {

        Contract entity = repository.findById(id).orElseThrow(() -> new NotFoundException(Contract.class));
        validation(entity, request);

        entity.setContractDetails(null);
//        entity.setContractContacts(null);

        List<ContractDetail> contractDetails = contractDetailDAO.getByContractId(entity.getId());
//        contractDetails.forEach(contractDetail -> contractDetail.setContractDetailValues(null));
        List<ContractContact> contractContacts = contractContactDAO.getByContractId(entity.getId());

        List<ContractDetailDTO.Update> contractDetailRqs = request.getContractDetails();
//        request.setContractDetails(null);

        // update contacts
        ContractContact buyer = contractContacts.stream().filter(item -> item.getCommercialRole() == CommercialRole.Buyer).findFirst().get();
        updateContractContacts(buyer, entity.getId(), request.getBuyerId(), CommercialRole.Buyer);
        ContractContact seller = contractContacts.stream().filter(item -> item.getCommercialRole() == CommercialRole.Seller).findFirst().get();
        updateContractContacts(seller, entity.getId(), request.getSellerId(), CommercialRole.Seller);
        if (request.getAgentBuyerId() != null) {

            ContractContact agentBuyer = contractContacts.stream().filter(item -> item.getCommercialRole() == CommercialRole.AgentBuyer).findFirst().get();
            updateContractContacts(agentBuyer, entity.getId(), request.getAgentBuyerId(), CommercialRole.AgentBuyer);
        }
        if (request.getAgentSellerId() != null) {

            ContractContact agentSeller = contractContacts.stream().filter(item -> item.getCommercialRole() == CommercialRole.AgentSeller).findFirst().get();
            updateContractContacts(agentSeller, entity.getId(), request.getAgentSellerId(), CommercialRole.AgentSeller);
        }

        //  update ContractDetails
        List<ContractDetailDTO.Create> contractDetail4Insert = new ArrayList<>();
        List<ContractDetailDTO.Update> contractDetail4Update = new ArrayList<>();
        ContractDetailDTO.Delete contractDetail4Delete = new ContractDetailDTO.Delete();
        try {
            updateUtil.fill(
                    ContractDetail.class,
                    contractDetails,
                    ContractDetailDTO.Update.class,
                    contractDetailRqs,
                    ContractDetailDTO.Create.class,
                    contractDetail4Insert,
                    ContractDetailDTO.Update.class,
                    contractDetail4Update,
                    contractDetail4Delete);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

            Locale locale = LocaleContextHolder.getLocale();
            String message = messageSource.getMessage(CONTRACT_DETAIL_EXCEPTION_UPDATE, null, locale);
            throw new SalesException2(ErrorType.Unknown, "", message);
        }

        if (!contractDetail4Delete.getIds().isEmpty()) {

            contractDetails.stream()
                    .filter(contractDetail -> contractDetail4Delete.getIds().contains(contractDetail.getId()))
                    .flatMap(contractDetail -> contractDetail.getContractDetailValues().stream()).forEach(this::deleteContractDetailValueExtras);

            contractDetailService.deleteAll(contractDetail4Delete);
            contractDetailService.flush();
        }
        createContractDetails(contractDetail4Insert, id);
        for (ContractDetailDTO.Update contractDetail : contractDetail4Update) {

            List<ContractDetailValueDTO.Update> contractDetailValueRqs = contractDetail.getContractDetailValues();

            contractDetail.setContractId(id);
            contractDetail.setContractDetailValues(null);
            ContractDetailDTO.Info savedContractDetail = contractDetailService.update(contractDetail);
            List<ContractDetailValue> contractDetailValues = contractDetailValueDAO.getByContractDetailId(savedContractDetail.getId());

            // update contractDetailValues
            List<ContractDetailValueDTO.Create> contractDetailValue4Insert = new ArrayList<>();
            List<ContractDetailValueDTO.Update> contractDetailValue4Update = new ArrayList<>();
            ContractDetailValueDTO.Delete contractDetailValue4Delete = new ContractDetailValueDTO.Delete();
            try {
                updateUtil.fill(
                        ContractDetailValue.class,
                        contractDetailValues,
                        ContractDetailValueDTO.Update.class,
                        contractDetailValueRqs,
                        ContractDetailValueDTO.Create.class,
                        contractDetailValue4Insert,
                        ContractDetailValueDTO.Update.class,
                        contractDetailValue4Update,
                        contractDetailValue4Delete);
            } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

                Locale locale = LocaleContextHolder.getLocale();
                String message = messageSource.getMessage(CONTRACT_DETAIL_EXCEPTION_UPDATE, null, locale);
                throw new SalesException2(ErrorType.Unknown, "", message);
            }

            if (!contractDetailValue4Delete.getIds().isEmpty()) {

                contractDetailValues.stream().
                        filter(contractDetailValue -> contractDetailValue4Delete.getIds().contains(contractDetailValue.getId())).
                        forEach(this::deleteContractDetailValueExtras);

                contractDetailValueService.deleteAll(contractDetailValue4Delete);
                contractDetailValueService.flush();
            }
            createContractDetailValues(contractDetailValue4Insert, id, savedContractDetail.getId());
            for (ContractDetailValueDTO.Update contractDetailValue : contractDetailValue4Update) {

                List<CDTPDynamicTableValueDTO.Update> dynamicTableValueRqs = contractDetailValue.getDynamicTableValues();

                updateContractDetailValueExtras(contractDetailValue);
                contractDetailValue.setDynamicTableValues(null);
                contractDetailValue.setContractDetailId(savedContractDetail.getId());
                ContractDetailValueDTO.Info savedContractDetailValue = contractDetailValueService.update(contractDetailValue);
                List<CDTPDynamicTableValue> dynamicTableValues = dynamicTableValueDAO.getByContractDetailValueId(savedContractDetailValue.getId());

                // update dynamicTableValues
                List<CDTPDynamicTableValueDTO.Create> dynamicTableValue4Insert = new ArrayList<>();
                List<CDTPDynamicTableValueDTO.Update> dynamicTableValue4Update = new ArrayList<>();
                CDTPDynamicTableValueDTO.Delete dynamicTableValue4Delete = new CDTPDynamicTableValueDTO.Delete();
                try {
                    updateUtil.fill(
                            CDTPDynamicTableValue.class,
                            dynamicTableValues,
                            CDTPDynamicTableValueDTO.Update.class,
                            dynamicTableValueRqs,
                            CDTPDynamicTableValueDTO.Create.class,
                            dynamicTableValue4Insert,
                            CDTPDynamicTableValueDTO.Update.class,
                            dynamicTableValue4Update,
                            dynamicTableValue4Delete);
                } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

                    Locale locale = LocaleContextHolder.getLocale();
                    String message = messageSource.getMessage(CONTRACT_DETAIL_EXCEPTION_UPDATE, null, locale);
                    throw new SalesException2(ErrorType.Unknown, "", message);
                }

                if (!dynamicTableValue4Delete.getIds().isEmpty()) {

                    dynamicTableValueService.deleteAll(dynamicTableValue4Delete);
                    contractDetailValueService.flush();
                }
                dynamicTableValue4Insert.forEach(dynamicTableValue -> dynamicTableValue.setContractDetailValueId(savedContractDetailValue.getId()));
                dynamicTableValueService.createAll(dynamicTableValue4Insert);
                dynamicTableValue4Update.forEach(dynamicTableValue -> dynamicTableValue.setContractDetailValueId(savedContractDetailValue.getId()));
                dynamicTableValueService.updateAll(dynamicTableValue4Update);
            }
        }

        Contract updating = repository.findById(id).get();
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Override
    @Transactional
    @Action(value = ActionType.Delete)
    public void delete(Long id) {

        final Contract entity = repository.findById(id).orElseThrow(() -> new NotFoundException(Contract.class));
        validation(entity, id);

        entity.getContractDetails().stream().flatMap(contractDetail -> contractDetail.getContractDetailValues().stream()).
                forEach(this::deleteContractDetailValueExtras);

        repository.deleteById(id);
    }

    @Override
    @CheckCriteria
    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public TotalResponse<ContractDTO.ListGridInfo> refinedSearch(NICICOCriteria request) {

        List<Contract> entities = new ArrayList<>();
        TotalResponse<ContractDTO.ListGridInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ContractDTO.ListGridInfo eResult = modelMapper.map(entity, ContractDTO.ListGridInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            eResult.getContractContacts().forEach(q -> {
                if (q.getCommercialRole() == CommercialRole.Buyer) eResult.setBuyerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.Seller) eResult.setSellerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.AgentBuyer) eResult.setAgentBuyerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.AgentSeller) eResult.setAgentSellerId(q.getContactId());
            });
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public SearchDTO.SearchRs<ContractDTO.ListGridInfo> refinedSearch(SearchDTO.SearchRq request) {

        List<Contract> entities = new ArrayList<>();
        SearchDTO.SearchRs<ContractDTO.ListGridInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ContractDTO.ListGridInfo eResult = modelMapper.map(entity, ContractDTO.ListGridInfo.class);
            validation(entity, eResult);
            entities.add(entity);
            eResult.getContractContacts().forEach(q -> {
                if (q.getCommercialRole() == CommercialRole.Buyer) eResult.setBuyerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.Seller) eResult.setSellerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.AgentBuyer) eResult.setAgentBuyerId(q.getContactId());
                if (q.getCommercialRole() == CommercialRole.AgentSeller) eResult.setAgentSellerId(q.getContactId());
            });
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    public Boolean validation(Contract entity, Object... request) {

        Locale locale = LocaleContextHolder.getLocale();

//        //شروع الحاقیه
//        final Calendar cal = Calendar.getInstance();
//        final Calendar kal = Calendar.getInstance();
//        ContractDTO.Create req = modelMapper.map(request[0], ContractDTO.Create.class);
//        if ((actionType == ActionType.Create || actionType == ActionType.Update) && req.getParentId() != null) {
//            final List<Contract> allAppendix = contractDAO2.findAllByParentId(req.getParentId());
//            //همپوشانی تاریخ الحاقیه‌ها
//            allAppendix.stream().forEach(contract -> {
//                req.getContractDetails().stream().forEach(reqCD -> {
//                    contract.getContractDetails().stream().forEach(aCD -> {
//                        if (aCD.getContractDetailTypeId().equals(reqCD.getContractDetailTypeId()) && req.getAffectFrom().after(contract.getAffectFrom()) && req.getAffectFrom().before(contract.getAffectUpTo())) {
//                            if ((actionType == ActionType.Update && !modelMapper.map(request[0], ContractDTO.Update.class).getId().equals(contract.getId())
//
//                            ) || actionType.equals(ActionType.Create)) {
//                                ContractDTO.Update reqUpdate = modelMapper.map(request[0], ContractDTO.Update.class);
//                                throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract.appendix.has.date.cover.issue", new Object[]{contract.getNo()}, locale));
//                            }
//                        }
//                    });
//                });
//            });
//            //همپوشانی تاریخ الحاقیه ها
////            if(actionType == ActionType.Create) {ContractDTO.Create req = modelMapper.map(request[0], ContractDTO.Create.class);}
//            final Contract contract = repository.getOne(req.getParentId());
//            if (!contract.getEStatus().contains(EStatus.Final)) {
//                throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("global.grid.not.finalized.record.found", null, locale));
//            }
//            final List<Contract> allByParentId = allAppendix;
//            final List<Contract> notFinalizedAppendexes = allByParentId.stream().filter(contract2 -> !contract2.getEStatus().contains(EStatus.Final)).collect(Collectors.toList());
//            if (actionType == ActionType.Update) {
//                ContractDTO.Update reqUpdate = modelMapper.map(request[0], ContractDTO.Update.class);
//                final List<Contract> collect = notFinalizedAppendexes.stream().filter(contract2 -> !contract2.getId().equals(reqUpdate.getId())).collect(Collectors.toList());
//                if (collect.size() != 0)
//                    throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("global.grid.not.finalized.record.found", null, locale));
//            }
//            if (actionType == ActionType.Create && notFinalizedAppendexes.size() > 0)
//                throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("global.grid.not.finalized.record.found", null, locale));
//            final List<ContractShipment> contractShipments = getContractShipmentsOfRequest(req);
//            if (contractShipments.size() == 0) return super.validation(entity, request);
//
//            final Set<ContractShipment> contractShipmentsOriginal = getContractShipmentsWithShipment(req);
//            final List<ContractShipment> modifiedFound = contractShipmentsOriginal.stream().filter(ocs -> {
//                final ContractShipment contractShipmentFromController = contractShipments.stream().filter(contractShipment -> contractShipment.getId().equals(ocs.getId()) || contractShipment.getParentId().equals(ocs.getId())).findAny().orElseThrow(() -> new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("shipment.was.sent", null, locale)));
//                cal.setTime(contractShipmentFromController.getSendDate());
//                kal.setTime(ocs.getSendDate());
//                return !contractShipmentFromController.getLoadPortId().equals(ocs.getLoadPortId()) || !contractShipmentFromController.getQuantity().equals(ocs.getQuantity()) || !contractShipmentFromController.getTolerance().equals(ocs.getTolerance()) || cal.get(Calendar.YEAR) != kal.get(Calendar.YEAR) || cal.get(Calendar.DAY_OF_YEAR) != kal.get(Calendar.DAY_OF_YEAR)
//                        //|| contractShipmentFromController.getParentId() != null
//                        ;
//            }).collect(Collectors.toList());
//            if (modifiedFound.size() > 0)
//                throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("shipment.was.sent", null, locale));
//
//        }

        if (actionType == ActionType.Disapprove) {

            Contract contract = repository.findById(entity.getId()).orElseThrow(() -> new NotFoundException(entity.getClass()));
            Map<Class<? extends BaseEntity>, List<BaseEntity>> relations = relationChecker.getRecordRelations(Contract.class, contract.getId(),
                    Arrays.asList(ContractDetail.class, ContractContact.class, ContractShipment.class, ContractDiscount.class, TypicalAssay.class, Deduction.class));
            if (relations.size() > 0) {
                String message;
                List<String> collect = relations.keySet().stream()
                        .map(Class::getSimpleName)
                        .map(s -> messageSource.getMessage("entity." + StringFormatUtil.makeMessageKey(s, "-"), null, locale))
                        .collect(Collectors.toList());
                message = messageSource.getMessage("global.grid.record.is.used.warn", new Object[]{collect}, locale);
                throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage(message, null, locale));
            }
        }

        return super.validation(entity, request);
    }

    /******************************************************************************************************************/
    /******************************************************************************************************************/

    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.List)
    public List<ContractDTO.Info> findAllByContractDetailTypeId(Long typeId) {
        return ((ContractDAO) repository).findAllByContractDetailTypeId(typeId).stream().map(contract -> modelMapper.map(contract, ContractDTO.Info.class)).collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    @Action(value = ActionType.Get)
    public List<Object> getOperationalDataOfContractArticle(Long contractId, String articleCode, String articleKey) {

        if (contractId == null) return new ArrayList<>();

        final EContractDetailTypeCode eContractDetailTypeCode = Arrays.stream(EContractDetailTypeCode.values()).filter(e -> e.getId().equals(articleCode)).findAny().orElseThrow(NotFoundException::new);
        final EContractDetailValueKey eContractDetailValueKeyOptional = Enums.getIfPresent(EContractDetailValueKey.class, articleKey).orNull();
        if (eContractDetailValueKeyOptional == null) throw new NotFoundException();
        final Map<String, List<Object>> map = contractDetailValueService2.get(contractId, eContractDetailTypeCode, eContractDetailValueKeyOptional, true);
        if (map.size() == 0) return new ArrayList<>();
        return map.get(eContractDetailValueKeyOptional.name());
    }

    /******************************************************************************************************************/

//    private List<ContractShipment> getContractShipmentsOfRequest(ContractDTO.Create req) {
//        return req.getContractDetails().stream().map(cd -> cd.getContractDetailValues().stream().filter(cdv -> cdv.getReference() != null && ((cdv.getReference().toLowerCase().equals("ContractShipment".toLowerCase())) || (cdv.getReference().toLowerCase().equals("CONTRACT_SHIPMENT".toLowerCase())))).collect(Collectors.toList())).flatMap(Collection::stream).map(contractDetailValue -> {
//            try {
//                return objectMapper.readValue(contractDetailValue.getReferenceJsonValue(), ContractShipment.class);
//            } catch (IOException e) {
//                log.warn("jackson objectMapper error ", e);
//                throw new SalesException2(e);
//            }
//        }).collect(Collectors.toList());
//    }
//
//    private Set<ContractShipment> getContractShipmentsWithShipment(ContractDTO.Create request) {
//        final Map<String, List<Object>> contractShipmentOriginalMap = contractDetailValueService2.get(request.getParentId(), EContractDetailTypeCode.Shipment, EContractDetailValueKey.NotImportant, true);
//        final List<ContractShipment> contractShipmentsOriginal = new ArrayList<>();
//        final List<Object> o = contractShipmentOriginalMap.get(EContractDetailValueKey.CONTRACT_SHIPMENT.name());
//        if (o != null) {
//            contractShipmentsOriginal.addAll(modelMapper.map(o, new TypeToken<List<ContractShipment>>() {
//            }.getType()));
//        }
//        final List<Shipment> allByContractShipmentIdIsIn = shipmentDAO.findAllByContractShipmentIdIsIn(contractShipmentsOriginal.stream().map(ContractShipment::getId).collect(Collectors.toList()));
//        final Set<ContractShipment> contractShipmentsWithParentOrInShipment = contractShipmentsOriginal.stream().filter(contractShipment -> contractShipment.getParentId() != null).collect(Collectors.toSet());
//        contractShipmentsWithParentOrInShipment.addAll(allByContractShipmentIdIsIn.stream().map(Shipment::getContractShipment).collect(Collectors.toSet()));
//        return contractShipmentsWithParentOrInShipment;
//    }

    /******************************************************************************************************************/
    /******************************************************************************************************************/
}