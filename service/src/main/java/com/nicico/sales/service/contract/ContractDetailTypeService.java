package com.nicico.sales.service.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.annotation.CheckCriteria;
import com.nicico.sales.dto.contract.CDTPDynamicTableDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.contract.*;
import com.nicico.sales.model.entities.contract.CDTPDynamicTable;
import com.nicico.sales.model.entities.contract.ContractDetailType;
import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;
import com.nicico.sales.model.entities.contract.ContractDetailTypeTemplate;
import com.nicico.sales.model.enumeration.DataType;
import com.nicico.sales.repository.contract.CDTPDynamicTableDAO;
import com.nicico.sales.repository.contract.ContractDetailTypeDAO;
import com.nicico.sales.service.GenericService;
import com.nicico.sales.utility.UpdateUtil;
import lombok.RequiredArgsConstructor;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeService extends GenericService<ContractDetailType, Long, ContractDetailTypeDTO.Create, ContractDetailTypeDTO.InfoWithoutDetail, ContractDetailTypeDTO.Update, ContractDetailTypeDTO.Delete> implements IContractDetailTypeService {

    private final UpdateUtil updateUtil;
    private final ResourceBundleMessageSource messageSource;
    @Autowired
    protected JpaSpecificationExecutor<ContractDetailType> repositorySpecificationExecutor;


    private final IContractService contractService;
    private final ICDTPDynamicTableService cdtpDynamicTableService;
    private final IContractDetailTypeParamService contractDetailTypeParamService;
    private final IContractDetailTypeTemplateService contractDetailTypeTemplateService;

    private final CDTPDynamicTableDAO cdtpDynamicTableDAO;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ContractDetailTypeDTO.InfoWithoutDetail create(ContractDetailTypeDTO.Create request) {

        ContractDetailTypeDTO.InfoWithoutDetail contractDetailTypeDTO = super.create(request);

        if (request.getContractDetailTypeParams() != null && request.getContractDetailTypeParams().size() > 0) {

            request.getContractDetailTypeParams().forEach(param -> {
                ContractDetailTypeParamDTO.Create paramCreateDTO = modelMapper.map(param, ContractDetailTypeParamDTO.Create.class);
                paramCreateDTO.setContractDetailTypeId(contractDetailTypeDTO.getId());
                ContractDetailTypeParamDTO.Info paramDTO = contractDetailTypeParamService.create(paramCreateDTO);

                Map<String, Set<CDTPDynamicTableDTO.InfoWithoutCDTP>> cdtpDynamicTableMap = new HashMap<>();
                request.getContractDetailTypeParams().stream().
                        filter(params -> params.getType().equals(DataType.DynamicTable)).
                        forEach(cdtp -> cdtpDynamicTableMap.put(cdtp.getKey(), cdtp.getDynamicTables()));

                if (cdtpDynamicTableMap.size() > 0) {

                    if (paramDTO.getType().equals(DataType.DynamicTable)) {
                        cdtpDynamicTableMap.get(paramDTO.getKey()).forEach(cdtpdt -> cdtpdt.setCdtpId(paramDTO.getId()));
                    }

                    List<CDTPDynamicTableDTO.InfoWithoutCDTP> dynamicTables = cdtpDynamicTableMap.values().stream().flatMap(Collection::stream).collect(Collectors.toList());
                    cdtpDynamicTableService.createAll(modelMapper.map(dynamicTables, new TypeToken<List<CDTPDynamicTableDTO.Create>>() {
                    }.getType()));
                }
            });
        }

        if (request.getContractDetailTypeTemplates() != null && request.getContractDetailTypeTemplates().size() > 0) {

            request.getContractDetailTypeTemplates().forEach(template -> {

                ContractDetailTypeTemplateDTO.Create templateDTO = modelMapper.map(template, ContractDetailTypeTemplateDTO.Create.class);
                templateDTO.setContractDetailTypeId(contractDetailTypeDTO.getId());
                contractDetailTypeTemplateService.create(templateDTO);
            });
        }

        return contractDetailTypeDTO;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public ContractDetailTypeDTO.InfoWithoutDetail update(Long id, ContractDetailTypeDTO.Update request) {

        ContractDetailType contractDetailType = repository.findById(id).orElseThrow(() -> new NotFoundException(ContractDetailType.class));

        try {
            updateTemplates(request, contractDetailType);
            updateParams(request, contractDetailType);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail-type.exception.update", null, locale));
        }

        ContractDetailType updating = new ContractDetailType();
        contractDetailType.setContractDetailTypeParams(null);
        contractDetailType.setContractDetailTypeTemplates(null);
        modelMapper.map(contractDetailType, updating);
        modelMapper.map(request, updating);

        validation(updating, request);
        return save(updating);
    }

    private void updateTemplates(ContractDetailTypeDTO.Update request, ContractDetailType contractDetailType) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<ContractDetailTypeTemplateDTO.Create> contractDetailTypeTemplates4Insert = new ArrayList<>();
        List<ContractDetailTypeTemplateDTO.Update> contractDetailTypeTemplates4Update = new ArrayList<>();
        ContractDetailTypeTemplateDTO.Delete contractDetailTypeTemplates4Delete = new ContractDetailTypeTemplateDTO.Delete();
        updateUtil.fill(ContractDetailTypeTemplate.class, contractDetailType.getContractDetailTypeTemplates(), ContractDetailTypeTemplateDTO.Info.class, request.getContractDetailTypeTemplates(), ContractDetailTypeTemplateDTO.Create.class, contractDetailTypeTemplates4Insert, ContractDetailTypeTemplateDTO.Update.class, contractDetailTypeTemplates4Update, contractDetailTypeTemplates4Delete);

        if (!contractDetailTypeTemplates4Delete.getIds().isEmpty())
            contractDetailTypeTemplateService.deleteAll(contractDetailTypeTemplates4Delete);
        contractDetailTypeTemplateService.flush();
        if (!contractDetailTypeTemplates4Insert.isEmpty())
            contractDetailTypeTemplateService.createAll(contractDetailTypeTemplates4Insert);
        if (!contractDetailTypeTemplates4Update.isEmpty())
            contractDetailTypeTemplates4Update.forEach(contractDetailTypeTemplateService::update);
    }

    private void updateParams(ContractDetailTypeDTO.Update request, ContractDetailType contractDetailType) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<ContractDetailTypeParamDTO.Create> contractDetailTypeParams4Insert = new ArrayList<>();
        List<ContractDetailTypeParamDTO.Update> contractDetailTypeParams4Update = new ArrayList<>();
        ContractDetailTypeParamDTO.Delete contractDetailTypeParams4Delete = new ContractDetailTypeParamDTO.Delete();
        updateUtil.fill(ContractDetailTypeParam.class, contractDetailType.getContractDetailTypeParams(), ContractDetailTypeParamDTO.Info.class, request.getContractDetailTypeParams(), ContractDetailTypeParamDTO.Create.class, contractDetailTypeParams4Insert, ContractDetailTypeParamDTO.Update.class, contractDetailTypeParams4Update, contractDetailTypeParams4Delete);

        if (!contractDetailTypeParams4Delete.getIds().isEmpty())
            contractDetailTypeParamService.deleteAll(contractDetailTypeParams4Delete);
        contractDetailTypeParamService.flush();
        for (int i = 0; i < contractDetailTypeParams4Insert.size(); i++) {

            ContractDetailTypeParamDTO.Create contractDetailTypeParam4Insert = contractDetailTypeParams4Insert.get(i);
            ContractDetailTypeParamDTO.Info savedContractDetailTypeParam = contractDetailTypeParamService.create(contractDetailTypeParam4Insert);
            Set<CDTPDynamicTableDTO.InfoWithoutCDTP> dynamicTables = contractDetailTypeParam4Insert.getDynamicTables();
            if (dynamicTables != null) for (CDTPDynamicTableDTO.InfoWithoutCDTP dynamicTable : dynamicTables) {

                dynamicTable.setCdtpId(savedContractDetailTypeParam.getId());
                cdtpDynamicTableService.create(modelMapper.map(dynamicTable, CDTPDynamicTableDTO.Create.class));
            }
        }
        for (int i = 0; i < contractDetailTypeParams4Update.size(); i++) {

            ContractDetailTypeParamDTO.Update contractDetailTypeParam4Update = contractDetailTypeParams4Update.get(i);
            @NotNull Long contractDetailTypeParam4UpdateId = contractDetailTypeParam4Update.getId();
            List<CDTPDynamicTable> savedDynamicTables = cdtpDynamicTableDAO.findAllByCdtpId(contractDetailTypeParam4UpdateId);

            List<CDTPDynamicTableDTO.Create> dynamicTables4Insert = new ArrayList<>();
            List<CDTPDynamicTableDTO.Update> dynamicTables4Update = new ArrayList<>();
            CDTPDynamicTableDTO.Delete dynamicTables4Delete = new CDTPDynamicTableDTO.Delete();
            updateUtil.fill(CDTPDynamicTable.class, savedDynamicTables, CDTPDynamicTableDTO.InfoWithoutCDTP.class, new ArrayList<>(contractDetailTypeParam4Update.getDynamicTables()), CDTPDynamicTableDTO.Create.class, dynamicTables4Insert, CDTPDynamicTableDTO.Update.class, dynamicTables4Update, dynamicTables4Delete);

            if (!dynamicTables4Delete.getIds().isEmpty()) cdtpDynamicTableService.deleteAll(dynamicTables4Delete);
            cdtpDynamicTableService.flush();
            if (!dynamicTables4Insert.isEmpty()) {

                dynamicTables4Insert.forEach(item -> item.setCdtpId(contractDetailTypeParam4UpdateId));
                cdtpDynamicTableService.createAll(dynamicTables4Insert);
            }
            if (!dynamicTables4Update.isEmpty()) {

                dynamicTables4Update.forEach(item -> item.setCdtpId(contractDetailTypeParam4UpdateId));
                dynamicTables4Update.forEach(cdtpDynamicTableService::update);
            }

            contractDetailTypeParam4Update.setDynamicTables(null);
            contractDetailTypeParamService.update(contractDetailTypeParam4Update);
        }
    }

    @Override
    public Boolean validation(ContractDetailType entity, Object... request) {
        Boolean validation = super.validation(entity, request);
        if (actionType == ActionType.Create) {
            if (entity.getCode().equals(EContractDetailTypeCode.Note.getId())) return true;
            if (((ContractDetailTypeDAO) repository).findByMaterialIdAndCode(entity.getMaterialId(), entity.getCode()).size() >= 1) {
                EContractDetailTypeCode eContractDetailTypeCode = Arrays.stream(EContractDetailTypeCode.values()).filter(q -> q.getId().equals(entity.getCode())).findFirst().get();
                throw new SalesException2(ErrorType.BadRequest, "code", messageSource.getMessage("contract-detail-type.code.unique.constraint.violation", new Object[]{eContractDetailTypeCode.name()}, LocaleContextHolder.getLocale()));
            }
        }

        if (actionType == ActionType.DeActivate) {
            List<String> contracts = contractService.findAllByContractDetailTypeId(entity.getId());
            if (!contracts.isEmpty()) {
                Locale locale = LocaleContextHolder.getLocale();
                Set<String> contractNoList = contracts.stream().collect(Collectors.toSet());
                throw new SalesException2(ErrorType.NotEditable, "", messageSource.getMessage("contract-detail-type.exception.cant.deactivate.has.contract", new Object[]{contractNoList}, locale));
            }
        }
        return validation;
    }

    @Override
    @CheckCriteria
    @Transactional(readOnly = true)
    @Action(value = ActionType.Search)
    public TotalResponse<ContractDetailTypeDTO.Info> completeSearch(NICICOCriteria request) {

        List<ContractDetailType> entities = new ArrayList<>();
        TotalResponse<ContractDetailTypeDTO.Info> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ContractDetailTypeDTO.Info eResult = modelMapper.map(entity, ContractDetailTypeDTO.Info.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    public SearchDTO.SearchRs<ContractDetailTypeDTO.Info> completeSearch(SearchDTO.SearchRq request) {

        List<ContractDetailType> entities = new ArrayList<>();
        SearchDTO.SearchRs<ContractDetailTypeDTO.Info> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            ContractDetailTypeDTO.Info eResult = modelMapper.map(entity, ContractDetailTypeDTO.Info.class);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }
}