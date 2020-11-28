package com.nicico.sales.service.contract;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.CDTPDynamicTableDTO;
import com.nicico.sales.dto.contract.ContractDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeParamDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeTemplateDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.ICDTPDynamicTableService;
import com.nicico.sales.iservice.contract.IContractDetailTypeParamService;
import com.nicico.sales.iservice.contract.IContractDetailTypeService;
import com.nicico.sales.iservice.contract.IContractDetailTypeTemplateService;
import com.nicico.sales.iservice.contract.IContractService;
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
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContractDetailTypeService extends GenericService<ContractDetailType, Long, ContractDetailTypeDTO.Create,
        ContractDetailTypeDTO.Info, ContractDetailTypeDTO.Update, ContractDetailTypeDTO.Delete> implements IContractDetailTypeService {

    private final UpdateUtil updateUtil;
    private final ResourceBundleMessageSource messageSource;
    private final IContractDetailTypeParamService contractDetailTypeParamService;
    private final IContractDetailTypeTemplateService contractDetailTypeTemplateService;
    private final ICDTPDynamicTableService cdtpDynamicTableService;
    private final ContractDetailTypeDAO contractDetailTypeDAO;
    private final CDTPDynamicTableDAO cdtpDynamicTableDAO;
    private final IContractService contractService;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public ContractDetailTypeDTO.Info create(ContractDetailTypeDTO.Create request) {

        final ContractDetailType contractDetailType = modelMapper.map(request, ContractDetailType.class);
        validation(contractDetailType, request);

        contractDetailType.setContractDetailTypeParams(null);
        contractDetailType.setContractDetailTypeTemplates(null);

        ContractDetailTypeDTO.Info savedContractDetailType = save(contractDetailType);
        if (request.getContractDetailTypeParams() != null && request.getContractDetailTypeParams().size() > 0) {

            final List<ContractDetailTypeParamDTO.Create> contractDetailTypeParamRqs = modelMapper
                    .map(request.getContractDetailTypeParams(),
                            new TypeToken<List<ContractDetailTypeParamDTO.Create>>() {
                            }.getType());
            contractDetailTypeParamRqs.forEach(q -> q.setContractDetailTypeId(savedContractDetailType.getId()));
            List<ContractDetailTypeParamDTO.Info> savedContractDetailTypeParam = contractDetailTypeParamService
                    .createAll(contractDetailTypeParamRqs);

            savedContractDetailType.setContractDetailTypeParams(savedContractDetailTypeParam);

            Map<String, Set<CDTPDynamicTableDTO.InfoWithoutCDTP>> cdtpDynamicTableMap = new HashMap<>();
            request.getContractDetailTypeParams().stream().
                    filter(param -> param.getType().equals(DataType.DynamicTable)).
                    forEach(cdtp -> cdtpDynamicTableMap.put(cdtp.getKey(), cdtp.getDynamicTables()));
            if (cdtpDynamicTableMap.size() > 0)
                savedContractDetailTypeParam.stream().
                        filter(param -> param.getType().equals(DataType.DynamicTable)).
                        forEach(cdtp -> cdtpDynamicTableMap.get(cdtp.getKey()).
                                forEach(cdtpdt -> cdtpdt.setCdtpId(cdtp.getId())));
            cdtpDynamicTableService.createAll(modelMapper
                    .map(cdtpDynamicTableMap.values().stream().flatMap(Collection::stream).collect(Collectors.toList()),
                            new TypeToken<List<CDTPDynamicTableDTO.Create>>() {
                            }.getType()
                    ));
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

        validation(updating, request);
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

        repository.delete(contractDetailType);
    }

    private void updateTemplates(ContractDetailTypeDTO.Update request, ContractDetailType contractDetailType) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<ContractDetailTypeTemplateDTO.Create> contractDetailTypeTemplates4Insert = new ArrayList<>();
        List<ContractDetailTypeTemplateDTO.Update> contractDetailTypeTemplates4Update = new ArrayList<>();
        ContractDetailTypeTemplateDTO.Delete contractDetailTypeTemplates4Delete = new ContractDetailTypeTemplateDTO.Delete();
        updateUtil.fill(
                ContractDetailTypeTemplate.class,
                contractDetailType.getContractDetailTypeTemplates(),
                ContractDetailTypeTemplateDTO.Info.class,
                request.getContractDetailTypeTemplates(),
                ContractDetailTypeTemplateDTO.Create.class,
                contractDetailTypeTemplates4Insert,
                ContractDetailTypeTemplateDTO.Update.class,
                contractDetailTypeTemplates4Update,
                contractDetailTypeTemplates4Delete);

        if (!contractDetailTypeTemplates4Insert.isEmpty())
            contractDetailTypeTemplateService.createAll(contractDetailTypeTemplates4Insert);
        if (!contractDetailTypeTemplates4Update.isEmpty())
            contractDetailTypeTemplates4Update.forEach(contractDetailTypeTemplateService::update);
        if (!contractDetailTypeTemplates4Delete.getIds().isEmpty())
            contractDetailTypeTemplateService.deleteAll(contractDetailTypeTemplates4Delete);
    }

    private void updateParams(ContractDetailTypeDTO.Update request, ContractDetailType contractDetailType) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<ContractDetailTypeParamDTO.Create> contractDetailTypeParams4Insert = new ArrayList<>();
        List<ContractDetailTypeParamDTO.Update> contractDetailTypeParams4Update = new ArrayList<>();
        ContractDetailTypeParamDTO.Delete contractDetailTypeParams4Delete = new ContractDetailTypeParamDTO.Delete();

        List<CDTPDynamicTableDTO.Create> cDTPDynamicTable4Insert = new ArrayList<>();
        List<CDTPDynamicTable> cDTPDynamicTable4Update = new ArrayList<>();

        final Set<Long> oldCdtpdtIds = request.getContractDetailTypeParams()
                .stream().filter(c -> DataType.DynamicTable.equals(c.getType()))
                .map(c -> cdtpDynamicTableDAO.getIdsByCtpId(c.getId()))
                .flatMap(Collection::stream).collect(Collectors.toSet());
        final Set<Long> cdtpidsForKeeping = request.getContractDetailTypeParams()
                .stream().filter(c -> DataType.DynamicTable.equals(c.getType())).map(c -> c.getDynamicTables().stream()
                        .filter(cdtpdt -> cdtpdt.getId() != null)
                        .map(cdtpdt -> cdtpdt.getId())
                        .collect(Collectors.toSet())
                ).flatMap(Collection::stream).collect(Collectors.toSet());
        oldCdtpdtIds.removeAll(cdtpidsForKeeping);
        if (oldCdtpdtIds.size() > 0) cdtpDynamicTableDAO.deleteAllByIdIn(oldCdtpdtIds);

        updateUtil.fill(
                ContractDetailTypeParam.class,
                contractDetailType.getContractDetailTypeParams(),
                ContractDetailTypeParamDTO.Info.class,
                request.getContractDetailTypeParams(),
                ContractDetailTypeParamDTO.Create.class,
                contractDetailTypeParams4Insert,
                ContractDetailTypeParamDTO.Update.class,
                contractDetailTypeParams4Update,
                contractDetailTypeParams4Delete);

        if (!contractDetailTypeParams4Insert.isEmpty()) {
            final List<ContractDetailTypeParamDTO.Info> cdtpInserted = contractDetailTypeParamService.createAll(contractDetailTypeParams4Insert);
            for (ContractDetailTypeParamDTO.Info cdtp : cdtpInserted) {
                final Set<CDTPDynamicTableDTO.InfoWithoutCDTP> dynamicTables = cdtp.getDynamicTables();
                List<CDTPDynamicTableDTO.Create> map = new ArrayList<>();
                if (cdtp.getDynamicTables() != null && cdtp.getDynamicTables().size() > 0)
                    map = modelMapper.map(
                            dynamicTables
                            , new TypeToken<List<CDTPDynamicTableDTO.Create>>() {
                            }.getType());
                if (!map.isEmpty()) {
                    map.forEach(cdtpdt -> cdtpdt.setCdtpId(cdtp.getId()));
                    final boolean b = cDTPDynamicTable4Insert.addAll(map);
                }
            }

        }
        if (!contractDetailTypeParams4Update.isEmpty()) {
            contractDetailTypeParams4Update.stream().filter(cdtp -> cdtp.getType().equals(DataType.DynamicTable)).forEach(cdtp -> {
                final Set<CDTPDynamicTableDTO.InfoWithoutCDTP> dynamicTables = cdtp.getDynamicTables().stream()
                        .filter(cdtpdt -> cdtpdt.getId() != null).collect(Collectors.toSet());
                cDTPDynamicTable4Insert.addAll(cdtp.getDynamicTables().stream().filter(cdtpdt -> cdtpdt.getId() == null)
                        .map(cdtpdt -> {
                            cdtpdt.setCdtpId(cdtp.getId());
                            return modelMapper.map(cdtpdt, CDTPDynamicTableDTO.Create.class);
                        }).collect(Collectors.toList()));
                final Set<CDTPDynamicTable> map = modelMapper.map(dynamicTables
                        , new TypeToken<Set<CDTPDynamicTable>>() {
                        }.getType());
                cDTPDynamicTable4Update.addAll(map);
            });
            if (!cDTPDynamicTable4Update.isEmpty()) {
                cdtpDynamicTableDAO.saveAll(cDTPDynamicTable4Update.stream().map(
                        cdtpDynamicTable -> {
                            final CDTPDynamicTable one = cdtpDynamicTableDAO.getOne(cdtpDynamicTable.getId());
                            modelMapper.map(cdtpDynamicTable, one);
                            return one;
                        }
                ).collect(Collectors.toList()));
                contractDetailTypeParams4Update.forEach(cdtp -> cdtp.setDynamicTables(null));
            }
            contractDetailTypeParamService.updateAll(contractDetailTypeParams4Update);

        }
        if (!cDTPDynamicTable4Insert.isEmpty()) cdtpDynamicTableDAO.saveAll(modelMapper.map(cDTPDynamicTable4Insert,
                new TypeToken<List<CDTPDynamicTable>>() {
                }.getType()));

        if (!contractDetailTypeParams4Delete.getIds().isEmpty())
            cdtpDynamicTableDAO.deleteAllByCdtpIdIn(contractDetailTypeParams4Delete.getIds());
        contractDetailTypeParamService.deleteAll(contractDetailTypeParams4Delete);
    }

    @Override
    public Boolean validation(ContractDetailType entity, Object... request) {
        Boolean validation = super.validation(entity, request);
        if (actionType == ActionType.Create) {
            if (entity.getCode().equals(EContractDetailTypeCode.Note.getId()))
                return true;
            if (contractDetailTypeDAO.findByMaterialIdAndCode(entity.getMaterialId(), entity.getCode()).size() >= 1) {
                EContractDetailTypeCode eContractDetailTypeCode = Arrays.stream(EContractDetailTypeCode.values()).filter(q -> q.getId().equals(entity.getCode())).findFirst().get();
                throw new SalesException2(ErrorType.BadRequest, "code",
                        messageSource.getMessage("contract-detail-type.code.unique.constraint.violation",
                                new Object[]{eContractDetailTypeCode.name()}, LocaleContextHolder.getLocale()));
            }
        }

        if (actionType == ActionType.DeActivate) {
            List<ContractDTO.Info> contracts = contractService.findAllByContractDetailTypeId(entity.getId());
            if (!contracts.isEmpty()) {
                Locale locale = LocaleContextHolder.getLocale();
                Set<String> contractNoList = contracts.stream().map(ContractDTO.Info::getNo).collect(Collectors.toSet());
                throw new SalesException2(ErrorType.NotEditable, "", messageSource.getMessage("contract-detail-type.exception.cant.deactivate.has.contract", new Object[]{contractNoList}, locale));
            }
        }
        return validation;
    }

}
