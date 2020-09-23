package com.nicico.sales.service.contract;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Enums;
import com.google.gson.Gson;
import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ContractShipmentDTO;
import com.nicico.sales.dto.DeductionDTO;
import com.nicico.sales.dto.TypicalAssayDTO;
import com.nicico.sales.dto.contract.*;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.EContractDetailValueKey;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IContractDetailValueService2;
import com.nicico.sales.iservice.IContractShipmentService;
import com.nicico.sales.iservice.IDeductionService;
import com.nicico.sales.iservice.ITypicalAssayService;
import com.nicico.sales.iservice.contract.*;
import com.nicico.sales.model.entities.base.ContractShipment;
import com.nicico.sales.model.entities.base.Shipment;
import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.entities.contract.ContractContact;
import com.nicico.sales.model.entities.contract.ContractDetail;
import com.nicico.sales.model.entities.contract.ContractDetailValue;
import com.nicico.sales.model.enumeration.CommercialRole;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.repository.ContractShipmentDAO;
import com.nicico.sales.repository.ShipmentDAO;
import com.nicico.sales.repository.contract.ContractDAO;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.utility.UpdateUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.TypeToken;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ContractService extends GenericService<Contract, Long, ContractDTO.Create, ContractDTO.Info, ContractDTO.Update, ContractDTO.Delete> implements IContractService {

    private final IContractDetailService contractDetailService;
    private final IContractContactService contractContactService;
    private final IContractShipmentService contractShipmentService;
    private final ITypicalAssayService typicalAssayService;
    private final IDeductionService deductionService;
    private final IContractDiscountService contractDiscountService;
    private final IContractDetailValueService contractDetailValueService;
    private final IContractDetailValueService2 contractDetailValueService2;
    private final ShipmentDAO shipmentDAO;
    private final ContractShipmentDAO contractShipmentDAO;
    private final UpdateUtil updateUtil;
    private final ObjectMapper objectMapper;
    private final Gson gson;
    private final ResourceBundleMessageSource messageSource;
    private final ContractDAO contractDAO2;


    @Override
    @Transactional
    @Action(ActionType.Create)
    public ContractDTO.Info create(ContractDTO.Create request) {

        final Contract contract = modelMapper.map(request, Contract.class);
        validation(contract, request);

        ///الحاقیه
        final List<ContractDetailDTO.Info> requestContractDetails = request.getContractDetails();
        Set<ContractShipment> contractShipmentsWithShipments = new HashSet<>();
        if (request.getParentId() != null) {
            contractShipmentsWithShipments = getContractShipmentsWithShipment(request);
        }
        contract.setContractDetails(null);
        contract.setContractContacts(null);
//        if (StringUtils.isEmpty(contract2.getNo()))
//        contract2.setNo(contractNoGenerator.createContractNo());

        ContractDTO.Info savedContract = save(contract);

        createContractContacts(savedContract.getId(), request.getBuyerId(), CommercialRole.Buyer);
        createContractContacts(savedContract.getId(), request.getSellerId(), CommercialRole.Seller);
        if (request.getAgentBuyerId() != null)
            createContractContacts(savedContract.getId(), request.getAgentBuyerId(), CommercialRole.AgentBuyer);
        if (request.getAgentSellerId() != null)
            createContractContacts(savedContract.getId(), request.getAgentSellerId(), CommercialRole.AgentSeller);

        if (requestContractDetails != null && requestContractDetails.size() > 0) {
            final List<ContractDetailDTO.Create> contractDetailsRqs = modelMapper.map(requestContractDetails, new TypeToken<List<ContractDetailDTO.Create>>() {
            }.getType());
            contractDetailsRqs.forEach(q -> {
                List<ContractDetailValueDTO.Create> contractDetailValues = q.getContractDetailValues();
                q.setContractId(savedContract.getId());
                ContractDetailDTO.Info savedContractDetail = contractDetailService.create(q);

                if (contractDetailValues != null && contractDetailValues.size() > 0) {
                    List<ContractDetailValueDTO.Create> contractDetailValueRqs = modelMapper.map(contractDetailValues, new TypeToken<List<ContractDetailValueDTO.Create>>() {
                    }.getType());
                    contractDetailValueRqs.forEach(x -> {
                        x.setContractDetailId(savedContractDetail.getId());

                        if (x.getType().name().equals("ListOfReference")) {
                            switch (x.getReference()) {
                                case "ContractShipment":
                                    x.setValue(createContractShipment(x, savedContract.getId()).toString());
                                    break;
                                case "TypicalAssay":
                                    x.setValue(createTypicalAssay(x, savedContract.getId()).toString());
                                    break;
                                case "Deduction":
                                    x.setValue(createDeduction(x, savedContract.getId()).toString());
                                    break;
                                case "Discount":
                                    x.setValue(createDiscount(x, savedContract.getId()).toString());
                                    break;
                            }
                        }

                        contractDetailValueService.create(x);
                    });
                }

            });
        }

        /***شروع الحاقیه***/
        if (contractShipmentsWithShipments.size() > 0 && requestContractDetails != null) {
            final Calendar cal = Calendar.getInstance();
            final Calendar kal = Calendar.getInstance();
            Set<ContractShipment> contractShipmentsFromAddendum = new HashSet<>(contractShipmentDAO.findByContractId(contract.getId()));
            if (contractShipmentsFromAddendum.size() > 0 && contractShipmentsWithShipments.size() > 0) {
                for (ContractShipment csws : contractShipmentsWithShipments) {
                    cal.setTime(csws.getSendDate());
                    final Long contractIdMain = csws.getContractId();
                    final Boolean[] found = {false};

                    for (ContractShipment csfa : contractShipmentsFromAddendum) {
                        kal.setTime(csfa.getSendDate());
                        if (found[0]) continue;
                        final Long addendumId = csfa.getContractId();
                        if (
                                !addendumId.equals(contractIdMain) &&
                                        csfa.getLoadPortId().equals(csws.getLoadPortId()) &&
                                        csfa.getTolorance().equals(csws.getTolorance()) &&
                                        csfa.getQuantity().equals(csws.getQuantity()) &&
                                        kal.get(Calendar.YEAR) == cal.get(Calendar.YEAR) &&
                                        kal.get(Calendar.DAY_OF_YEAR) == cal.get(Calendar.DAY_OF_YEAR)
                        ) {
                            found[0] = true;
                            if (csfa.getParentId() == null || csfa.getParentId().equals(csws.getParentId()))
                                csfa.setParentId(csws.getId());
                            contractShipmentDAO.save(csfa);
                        }
                    }
                    if (!found[0]) throw new SalesException2(ErrorType.NotFound);
                }

            }
        }

        /***پایان الحاقیه***/

        return savedContract;
    }


    private Long createContractShipment(ContractDetailValueDTO.Create x, Long id) {
        ContractShipmentDTO.Create contractShipmentDTO = gson.fromJson(x.getReferenceJsonValue(), ContractShipmentDTO.Create.class);
        contractShipmentDTO.setContractId(id);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(contractShipmentDTO.getSendDate());
        calendar.set(Calendar.HOUR_OF_DAY, 12);
        contractShipmentDTO.setSendDate(calendar.getTime());
        ContractShipmentDTO.Info savedContractShipment = contractShipmentService.create(contractShipmentDTO);
        return savedContractShipment.getId();
    }

    private Long createTypicalAssay(ContractDetailValueDTO.Create x, Long id) {
        TypicalAssayDTO.Create typicalAssayDTO = gson.fromJson(x.getReferenceJsonValue(), TypicalAssayDTO.Create.class);
        typicalAssayDTO.setContractId(id);
        TypicalAssayDTO.Info savedTypicalAssay = typicalAssayService.create(typicalAssayDTO);
        return savedTypicalAssay.getId();
    }

    private Long createDeduction(ContractDetailValueDTO.Create x, Long id) {
        DeductionDTO.Create deductionDTO = gson.fromJson(x.getReferenceJsonValue(), DeductionDTO.Create.class);
        deductionDTO.setContractId(id);
        DeductionDTO.Info savedDeduction = deductionService.create(deductionDTO);
        return savedDeduction.getId();
    }

    private Long createDiscount(ContractDetailValueDTO.Create x, Long id) {
        ContractDiscountDTO.Create contractDiscountDto = gson.fromJson(x.getReferenceJsonValue(), ContractDiscountDTO.Create.class);
        contractDiscountDto.setContractId(id);
        ContractDiscountDTO.Info savedContractDiscount = contractDiscountService.create(contractDiscountDto);
        return savedContractDiscount.getId();
    }

    private void updateContractShipment(ContractDetailValueDTO.Update x) {
        ContractShipmentDTO.Update contractShipmentDTO = gson.fromJson(x.getReferenceJsonValue(), ContractShipmentDTO.Update.class);
        contractShipmentService.update(contractShipmentDTO.getId(), contractShipmentDTO);
    }

    private void updateTypicalAssay(ContractDetailValueDTO.Update x) {
        TypicalAssayDTO.Update typicalAssayDTO = gson.fromJson(x.getReferenceJsonValue(), TypicalAssayDTO.Update.class);
        typicalAssayService.update(typicalAssayDTO.getId(), typicalAssayDTO);
    }

    private void updateDeduction(ContractDetailValueDTO.Update x) {
        DeductionDTO.Update deductionDTO = gson.fromJson(x.getReferenceJsonValue(), DeductionDTO.Update.class);
        deductionService.update(deductionDTO.getId(), deductionDTO);
    }

    private void updateDiscount(ContractDetailValueDTO.Update x) {
        ContractDiscountDTO.Update contractDiscountDto = gson.fromJson(x.getReferenceJsonValue(), ContractDiscountDTO.Update.class);
        contractDiscountService.update(contractDiscountDto.getId(), contractDiscountDto);
    }

    private void createContractContacts(Long contractId, Long contactId, CommercialRole commercialRole) {
        ContractContactDTO.Create contractContactDTO = new ContractContactDTO.Create();
        contractContactDTO.setContractId(contractId);
        contractContactDTO.setContactId(contactId);
        contractContactDTO.setCommercialRole(commercialRole);
        contractContactService.create(contractContactDTO);
    }

    private void updateContractContacts(Long newContractContactId, CommercialRole commercialRole, Contract contract) {
        ContractContactDTO.Update contractContactDTO = new ContractContactDTO.Update();
        Optional<ContractContact> oldContractContact = contract.getContractContacts().stream().filter(item -> item.getCommercialRole() == commercialRole).findFirst();
        if (oldContractContact.isPresent()) {
            ContractContactDTO.Info foundContractContact = contractContactService.getByContractIdAndContactIdAndCommercialRole(contract.getId(), oldContractContact.get().getContact().getId(), commercialRole);
            contractContactDTO.setId(foundContractContact.getId());
            contractContactDTO.setContractId(contract.getId());
            contractContactDTO.setContactId(newContractContactId);
            contractContactDTO.setCommercialRole(commercialRole);
            contractContactDTO.setVersion(foundContractContact.getVersion());
            contractContactService.update(contractContactDTO);
        } else
            createContractContacts(contract.getId(), newContractContactId, commercialRole);
    }

    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public TotalResponse<ContractDTO.ListGridInfo> refinedSearch(NICICOCriteria request) {

        List<Contract> entities = new ArrayList<>();
        TotalResponse<ContractDTO.ListGridInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ContractDTO.ListGridInfo eResult = modelMapper.map(entity, ContractDTO.ListGridInfo.class);
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

    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public SearchDTO.SearchRs<ContractDTO.ListGridInfo> refinedSearch(SearchDTO.SearchRq request) {

        List<Contract> entities = new ArrayList<>();
        SearchDTO.SearchRs<ContractDTO.ListGridInfo> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ContractDTO.ListGridInfo eResult = modelMapper.map(entity, ContractDTO.ListGridInfo.class);
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
    public ContractDTO.Info update(Long id, ContractDTO.Update request) {
        final ContractDTO.Update requestForValidation = new ContractDTO.Update();
        modelMapper.map(request, requestForValidation);
        Contract contract = repository.findById(id).orElseThrow(() -> new NotFoundException(Contract.class));

        // update ContractContacts
        updateContractContacts(request.getBuyerId(), CommercialRole.Buyer, contract);
        updateContractContacts(request.getSellerId(), CommercialRole.Seller, contract);
        if (request.getAgentBuyerId() != null)
            updateContractContacts(request.getAgentBuyerId(), CommercialRole.AgentBuyer, contract);
        if (request.getAgentSellerId() != null)
            updateContractContacts(request.getAgentSellerId(), CommercialRole.AgentSeller, contract);

        //  update ContractDetails
        List<ContractDetailDTO.Create> contractDetail4Insert = new ArrayList<>();
        List<ContractDetailDTO.Update> contractDetail4Update = new ArrayList<>();
        ContractDetailDTO.Delete contractDetail4Delete = new ContractDetailDTO.Delete();

        try {
            updateUtil.fill(ContractDetail.class, contract.getContractDetails(),
                    ContractDetailDTO.Info.class, request.getContractDetails(),
                    ContractDetailDTO.Create.class, contractDetail4Insert,
                    ContractDetailDTO.Update.class, contractDetail4Update,
                    contractDetail4Delete);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {
            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail.exception.update", null, locale));
        }

        if (!contractDetail4Insert.isEmpty()) {
            contractDetail4Insert.forEach(q -> {
                List<ContractDetailValueDTO.Create> contractDetailValues = q.getContractDetailValues();
                q.setContractId(contract.getId());
                ContractDetailDTO.Info savedContractDetail = contractDetailService.create(q);

                if (contractDetailValues != null && contractDetailValues.size() > 0) {
                    List<ContractDetailValueDTO.Create> contractDetailValueRqs = modelMapper.map(contractDetailValues, new TypeToken<List<ContractDetailValueDTO.Create>>() {
                    }.getType());
                    contractDetailValueRqs.forEach(x -> {
                        x.setContractDetailId(savedContractDetail.getId());

                        if (x.getType().name().equals("ListOfReference")) {
                            switch (x.getReference()) {
                                case "ContractShipment":
                                    x.setValue(createContractShipment(x, contract.getId()).toString());
                                    break;
                                case "TypicalAssay":
                                    x.setValue(createTypicalAssay(x, contract.getId()).toString());
                                    break;
                                case "Deduction":
                                    x.setValue(createDeduction(x, contract.getId()).toString());
                                    break;
                                case "Discount":
                                    x.setValue(createDiscount(x, contract.getId()).toString());
                                    break;
                            }
                        }

                        contractDetailValueService.create(x);
                    });
                }

            });
        }

        if (!contractDetail4Update.isEmpty()) {
            for (ContractDetailDTO.Update q : contractDetail4Update) {
                q.setContractId(contract.getId());
                ContractDetailDTO.Info savedContractDetail = contractDetailService.update(q);

                List<ContractDetailValueDTO.Create> contractDetailValue4Insert = new ArrayList<>();
                List<ContractDetailValueDTO.Update> contractDetailValue4Update = new ArrayList<>();
                ContractDetailValueDTO.Delete contractDetailValue4Delete = new ContractDetailValueDTO.Delete();

                try {
                    updateUtil.fill(ContractDetailValue.class, modelMapper.map(savedContractDetail.getContractDetailValues(), new TypeToken<List<ContractDetailValue>>() {
                            }.getType()),
                            ContractDetailValueDTO.Info.class, request.getContractDetails().stream().filter(w -> q.getId().equals(w.getId())).findFirst().get().getContractDetailValues(),
                            ContractDetailValueDTO.Create.class, contractDetailValue4Insert,
                            ContractDetailValueDTO.Update.class, contractDetailValue4Update,
                            contractDetailValue4Delete);
                } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {
                    Locale locale = LocaleContextHolder.getLocale();
                    throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail.exception.update", null, locale));
                }

                if (!contractDetailValue4Insert.isEmpty()) {
                    contractDetailValue4Insert.forEach(x -> {
                        //based on reference, first we have to update records in reference tables
                        if (x.getType().name().equals("ListOfReference")) {
                            switch (x.getReference()) {
                                case "ContractShipment":
                                    x.setValue(createContractShipment(x, contract.getId()).toString());
                                    break;
                                case "TypicalAssay":
                                    x.setValue(createTypicalAssay(x, contract.getId()).toString());
                                    break;
                                case "Deduction":
                                    x.setValue(createDeduction(x, contract.getId()).toString());
                                    break;
                                case "Discount":
                                    x.setValue(createDiscount(x, contract.getId()).toString());
                                    break;
                            }
                        }
                        contractDetailValueService.create(x);
                    });
                }
                if (!contractDetailValue4Update.isEmpty()) {
                    //based on reference type, first we must update records in reference table
                    contractDetailValue4Update.forEach(x -> {
                        if (x.getType().name().equals("ListOfReference")) {
                            //based on reference, first we have to update records in reference tables
                            if (x.getType().name().equals("ListOfReference")) {
                                switch (x.getReference()) {
                                    case "ContractShipment":
                                        updateContractShipment(x);
                                        break;
                                    case "TypicalAssay":
                                        updateTypicalAssay(x);
                                        break;
                                    case "Deduction":
                                        updateDeduction(x);
                                        break;
                                    case "Discount":
                                        updateDiscount(x);
                                        break;
                                }
                            }

                        }
                        contractDetailValueService.update(x);
                    });
                }
                if (!contractDetailValue4Delete.getIds().isEmpty()) {
                    request.getContractDetails().stream().filter(w -> q.getId().equals(w.getId())).findFirst().get().getContractDetailValues().stream()
                            .filter(contractDetailValue -> contractDetailValue4Delete.getIds().contains(contractDetailValue.getId()))
                            .forEach(detail -> {
                                switch (detail.getReference()) {
                                    case "ContractShipment":
                                        contractShipmentService.delete(Long.valueOf(detail.getValue()));
                                        break;
                                    case "TypicalAssay":
                                        typicalAssayService.delete(Long.valueOf(detail.getValue()));
                                        break;
                                    case "Deduction":
                                        deductionService.delete(Long.valueOf(detail.getValue()));
                                        break;
                                    case "Discount":
                                        contractDiscountService.delete(Long.valueOf(detail.getValue()));
                                        break;
                                }
                            });

                    contractDetailValueService.deleteAll(contractDetailValue4Delete);

                }
            }
        }

        if (!contractDetail4Delete.getIds().isEmpty()) {
            contract.getContractDetails().stream().filter(contractDetail -> contractDetail4Delete.getIds().contains(contractDetail.getId()))
                    .forEach(x -> x.getContractDetailValues().stream().filter(detailValue -> detailValue.getType().name().equals("ListOfReference")).forEach(
                            t -> {
                                switch (t.getReference()) {
                                    case "ContractShipment":
                                        contractShipmentService.delete(Long.valueOf(t.getValue()));
                                        break;
                                    case "TypicalAssay":
                                        typicalAssayService.delete(Long.valueOf(t.getValue()));
                                        break;
                                    case "Deduction":
                                        deductionService.delete(Long.valueOf(t.getValue()));
                                        break;
                                    case "Discount":
                                        contractDiscountService.delete(Long.valueOf(t.getValue()));
                                        break;
                                }
                            }
                    ));

            contractDetailService.deleteAll(contractDetail4Delete);
        }

        Contract updating = new Contract();

        validation(contract, request);
        contract.setContractDetails(null);
        request.setContractDetails(null);

        modelMapper.map(contract, updating);
        modelMapper.map(request, updating);
        updating.setContractContacts(null);

        return save(updating);
    }

    @Override
    @Transactional
    @Action(value = ActionType.Delete)
    public void delete(Long id) {

        final Optional<Contract> entityById = repository.findById(id);
        final Contract entity = entityById.orElseThrow(() -> new NotFoundException(Contract.class));

        validation(entity, id);

        if (entity.getContractDetails() != null && entity.getContractDetails().size() > 0) {
            entity.getContractDetails().forEach(q -> {
                if (q.getContractDetailValues() != null && q.getContractDetailValues().size() > 0) {
                    q.getContractDetailValues().forEach(x -> {
                        if (x.getType() == DataType.ListOfReference) {
                            switch (x.getReference()) {
                                case "ContractShipment":
                                    contractShipmentService.delete(Long.valueOf(x.getValue()));
                                    break;
                                case "TypicalAssay":
                                    typicalAssayService.delete(Long.valueOf(x.getValue()));
                                    break;
                                case "Deduction":
                                    deductionService.delete(Long.valueOf(x.getValue()));
                                    break;
                                case "Discount":
                                    contractDiscountService.delete(Long.valueOf(x.getValue()));
                                    break;
                            }
                        }
                    });
                }
            });
        }

        repository.deleteById(id);
    }

    @Override
    public Boolean validation(Contract entity, Object... request) {
        /***شروع الحاقیه***/
        final Calendar cal = Calendar.getInstance();
        final Calendar kal = Calendar.getInstance();
        Locale locale = LocaleContextHolder.getLocale();
        ContractDTO.Create req = modelMapper.map(request[0], ContractDTO.Create.class);
        if ((actionType == ActionType.Create || actionType == ActionType.Update) && req.getParentId() != null) {
//            if(actionType == ActionType.Create) {ContractDTO.Create req = modelMapper.map(request[0], ContractDTO.Create.class);}
            final Contract contract = repository.getOne(req.getParentId());
            if (!contract.getEStatus().contains(EStatus.Final)) {
                throw new SalesException2(ErrorType.Unknown, "",
                        messageSource.getMessage("global.grid.not.finalized.record.found", null, locale));
            }
            final List<Contract> allByParentId = contractDAO2.findAllByParentId(req.getParentId());
            final List<Contract> notFinalizedAppendexes = allByParentId.stream()
                    .filter(contract2 -> !contract2.getEStatus().contains(EStatus.Final)).collect(Collectors.toList());
            if (actionType == ActionType.Update) {
                ContractDTO.Update reqUpdate = modelMapper.map(request[0], ContractDTO.Update.class);
                final List<Contract> collect = notFinalizedAppendexes.stream()
                        .filter(contract2 -> !contract2.getId().equals(reqUpdate.getId())).collect(Collectors.toList());
                if (collect.size() != 0) throw new SalesException2(ErrorType.Unknown, "",
                        messageSource.getMessage("global.grid.not.finalized.record.found", null, locale));
            }
            if (actionType == ActionType.Create && notFinalizedAppendexes.size() > 0)
                throw new SalesException2(ErrorType.Unknown, "",
                        messageSource.getMessage("global.grid.not.finalized.record.found", null, locale));
            final List<ContractShipment> contractShipments = getContractShipmentsOfRequest(req);
            if (contractShipments.size() == 0) return super.validation(entity, request);

            final Set<ContractShipment> contractShipmentsOriginal = getContractShipmentsWithShipment(req);
            final List<ContractShipment> modifiedFound = contractShipmentsOriginal.stream().filter(ocs -> {
                final ContractShipment contractShipmentFromController = contractShipments
                        .stream()
                        .filter(contractShipment -> contractShipment.getId().equals(ocs.getId()) ||
                                contractShipment.getParentId().equals(ocs.getId()))
                        .findAny()
                        .orElseThrow(() -> new SalesException2(ErrorType.Unknown, "",
                                messageSource.getMessage("shipment.was.sent", null, locale)));
                cal.setTime(contractShipmentFromController.getSendDate());
                kal.setTime(ocs.getSendDate());
                return !contractShipmentFromController.getLoadPortId().equals(ocs.getLoadPortId()) ||
                        !contractShipmentFromController.getQuantity().equals(ocs.getQuantity()) ||
                        !contractShipmentFromController.getTolorance().equals(ocs.getTolorance()) ||
                        cal.get(Calendar.YEAR) != kal.get(Calendar.YEAR) ||
                        cal.get(Calendar.DAY_OF_YEAR) != kal.get(Calendar.DAY_OF_YEAR)
                        //|| contractShipmentFromController.getParentId() != null
                        ;
            }).collect(Collectors.toList());
            if (modifiedFound.size() > 0) throw new SalesException2(ErrorType.Unknown, "",
                    messageSource.getMessage("shipment.was.sent", null, locale));

        }


        /*** الحاقیه***/

        return super.validation(entity, request);
    }

    /***شروع الحاقیه
     * @return***/

    @Override
    public List<Object> getOperationalDataOfContractArticle(Long contractId, String articleCode, String articleKey) {

        if (contractId == null)
            return new ArrayList<>();

        final EContractDetailTypeCode eContractDetailTypeCode = Arrays.stream(EContractDetailTypeCode.values())
                .filter(e -> e
                        .getId().equals(articleCode)).findAny()
                .orElseThrow(NotFoundException::new);
        final EContractDetailValueKey eContractDetailValueKeyOptional = Enums.getIfPresent(EContractDetailValueKey.class,
                articleKey).orNull();
        if (eContractDetailValueKeyOptional == null) throw new NotFoundException();
        final Map<String, List<Object>> map = contractDetailValueService2.get(contractId,
                eContractDetailTypeCode,
                eContractDetailValueKeyOptional, true
        );
        if (map.size() == 0) return new ArrayList<>();
        return map.get(eContractDetailValueKeyOptional.name());
    }

    private Set<ContractShipment> getContractShipmentsWithShipment(ContractDTO.Create request) {
        final Map<String, List<Object>> contractShipmentOriginalMap = contractDetailValueService2.get(request.getParentId(),
                EContractDetailTypeCode.Shipment, EContractDetailValueKey.NotImportant, true);
        final List<ContractShipment> contractShipmentsOriginal = new ArrayList<>();
        final List<Object> o = contractShipmentOriginalMap.get(EContractDetailValueKey.CONTRACT_SHIPMENT.name());
        if (o != null) {
            contractShipmentsOriginal.addAll(modelMapper.map(o,
                    new TypeToken<List<ContractShipment>>() {
                    }.getType())
            );
        }
        final List<Shipment> allByContractShipmentIdIsIn = shipmentDAO
                .findAllByContractShipmentIdIsIn(contractShipmentsOriginal.stream()
                        .map(ContractShipment::getId).collect(Collectors.toList()));
        final Set<ContractShipment> contractShipmentsWithParentOrInShipment = contractShipmentsOriginal.stream()
                .filter(contractShipment -> contractShipment.getParentId() != null).collect(Collectors.toSet());
        contractShipmentsWithParentOrInShipment
                .addAll(allByContractShipmentIdIsIn.stream().map(Shipment::getContractShipment).collect(Collectors.toSet()));
        return contractShipmentsWithParentOrInShipment;
    }

    private List<ContractShipment> getContractShipmentsOfRequest(ContractDTO.Create req) {
        return req.getContractDetails().stream()
                .map(cd -> cd.getContractDetailValues()
                        .stream().filter(cdv -> cdv.getReference() != null &&
                                (cdv.getReference().toLowerCase().equals("ContractShipment".toLowerCase())) ||
                                (cdv.getReference().toLowerCase().equals("CONTRACT_SHIPMENT".toLowerCase()))
                        )
                        .collect(Collectors.toList())
                ).flatMap(Collection::stream).map(contractDetailValue -> {
                    try {
                        return objectMapper.readValue(contractDetailValue.getReferenceJsonValue(), ContractShipment.class);
                    } catch (IOException e) {
                        log.warn("jackson objectMapper error ", e);
                    }
                    return null;
                })
                .collect(Collectors.toList());
    }
}

/*** الحاقیه***/
