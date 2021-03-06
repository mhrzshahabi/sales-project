package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.dto.AssayInspectionTotalValuesDTO;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.entities.base.AssayInspectionTotalValues;
import com.nicico.sales.model.entities.base.InspectionReport;
import com.nicico.sales.model.entities.base.WeightInspection;
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

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

    private final UpdateUtil updateUtil;
    private final ResourceBundleMessageSource messageSource;
    private final AssayInspectionService assayInspectionService;
    private final WeightInspectionService weightInspectionService;
    private final AssayInspectionTotalValuesService assayInspectionTotalValuesService;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public InspectionReportDTO.Info create(InspectionReportDTO.Create request) {

        InspectionReportDTO.Info inspectionReportDTO = super.create(request);

        Locale locale = LocaleContextHolder.getLocale();
        if (request.getWeightInspections().size() == 0 && request.getAssayInspections().size() == 0)
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("weight-inspection.exception.notFound", null, locale));

        request.getWeightInspections().forEach(item -> item.setInspectionReportId(inspectionReportDTO.getId()));
        weightInspectionService.createAll(modelMapper.map(request.getWeightInspections(), new TypeToken<List<WeightInspectionDTO.Create>>() {
        }.getType()));

        request.getAssayInspections().forEach(item -> item.setInspectionReportId(inspectionReportDTO.getId()));
        assayInspectionService.createAll(modelMapper.map(request.getAssayInspections(), new TypeToken<List<AssayInspectionDTO.Create>>() {
        }.getType()));

        if (request.getAssayInspectionTotalValuesList() != null) {
            request.getAssayInspectionTotalValuesList().forEach(item -> item.setInspectionReportId(inspectionReportDTO.getId()));
            assayInspectionTotalValuesService.createAll(modelMapper.map(request.getAssayInspectionTotalValuesList(), new TypeToken<List<AssayInspectionTotalValuesDTO.Create>>() {
            }.getType()));
        }

        return inspectionReportDTO;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public InspectionReportDTO.Info update(Long id, InspectionReportDTO.Update request) {

        request.getWeightInspections().forEach(item -> item.setInspectionReportId(request.getId()));
        request.getAssayInspections().forEach(item -> item.setInspectionReportId(request.getId()));
        request.getAssayInspectionTotalValuesList().forEach(item -> item.setInspectionReportId(request.getId()));
        InspectionReport inspectionReport = repository.findById(id).orElseThrow(() -> new NotFoundException(InspectionReport.class));

        try {

            updateWeight(request, inspectionReport);
            updateAssay(request, inspectionReport);
            updateAssayTotalValues(request, inspectionReport);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("inspection-report.exception.update", null, locale));
        }

        InspectionReport updating = new InspectionReport();
        modelMapper.map(inspectionReport, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        return save(updating);
    }

    @Override
    public InspectionReportDTO.Info setShipment(Long inspectionId, Long shipmentId) {

        InspectionReport inspectionReport = repository.findById(inspectionId).orElseThrow(() -> new NotFoundException(InspectionReport.class));
        inspectionReport.getWeightInspections().forEach(q -> q.setShipmentId(shipmentId));
        inspectionReport.getAssayInspections().forEach(q -> q.setShipmentId(shipmentId));
        InspectionReportDTO.Info inspectionReportDTO = modelMapper.map(inspectionReport, InspectionReportDTO.Info.class);

        return inspectionReportDTO;
    }

    private void updateWeight(InspectionReportDTO.Update request, InspectionReport inspectionReport) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<WeightInspectionDTO.Create> weightInspection4Insert = new ArrayList<>();
        List<WeightInspectionDTO.Update> weightInspection4Update = new ArrayList<>();
        WeightInspectionDTO.Delete weightInspection4Delete = new WeightInspectionDTO.Delete();

        updateUtil.fill(WeightInspection.class, inspectionReport.getWeightInspections(), WeightInspectionDTO.InfoWithoutInspectionReport.class, request.getWeightInspections(), WeightInspectionDTO.Create.class, weightInspection4Insert, WeightInspectionDTO.Update.class, weightInspection4Update, weightInspection4Delete);
        if (!weightInspection4Delete.getIds().isEmpty()) {
            List<WeightInspection> deleted = inspectionReport.getWeightInspections().stream().filter(assayInspection -> weightInspection4Delete.getIds().contains(assayInspection.getId())).collect(Collectors.toList());
            inspectionReport.getWeightInspections().removeAll(deleted);
            weightInspectionService.deleteAll(weightInspection4Delete);
            repository.flush();
        }
        if (!weightInspection4Insert.isEmpty()) weightInspectionService.createAll(weightInspection4Insert);
        if (!weightInspection4Update.isEmpty()) weightInspectionService.updateAll(weightInspection4Update);
    }

    private void updateAssay(InspectionReportDTO.Update request, InspectionReport inspectionReport) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<AssayInspectionDTO.Create> assayInspection4Insert = new ArrayList<>();
        List<AssayInspectionDTO.Update> assayInspection4Update = new ArrayList<>();
        AssayInspectionDTO.Delete assayInspection4Delete = new AssayInspectionDTO.Delete();

        updateUtil.fill(AssayInspection.class, inspectionReport.getAssayInspections(), AssayInspectionDTO.InfoWithoutInspectionReport.class, request.getAssayInspections(), AssayInspectionDTO.Create.class, assayInspection4Insert, AssayInspectionDTO.Update.class, assayInspection4Update, assayInspection4Delete);
        if (!assayInspection4Delete.getIds().isEmpty()) {
            List<AssayInspection> deleted = inspectionReport.getAssayInspections().stream().filter(assayInspection -> assayInspection4Delete.getIds().contains(assayInspection.getId())).collect(Collectors.toList());
            inspectionReport.getAssayInspections().removeAll(deleted);
            assayInspectionService.deleteAll(assayInspection4Delete);
            repository.flush();
        }
        if (!assayInspection4Insert.isEmpty()) assayInspectionService.createAll(assayInspection4Insert);
        if (!assayInspection4Update.isEmpty()) assayInspectionService.updateAll(assayInspection4Update);
    }

    private void updateAssayTotalValues(InspectionReportDTO.Update request, InspectionReport inspectionReport) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<AssayInspectionTotalValuesDTO.Create> assayInspectionTotalValues4Insert = new ArrayList<>();
        List<AssayInspectionTotalValuesDTO.Update> assayInspectionTotalValues4Update = new ArrayList<>();
        AssayInspectionTotalValuesDTO.Delete assayInspectionTotalValues4Delete = new AssayInspectionTotalValuesDTO.Delete();

        updateUtil.fill(AssayInspectionTotalValues.class, inspectionReport.getAssayInspectionTotalValuesList(), AssayInspectionTotalValuesDTO.Info.class, request.getAssayInspectionTotalValuesList(), AssayInspectionTotalValuesDTO.Create.class, assayInspectionTotalValues4Insert, AssayInspectionTotalValuesDTO.Update.class, assayInspectionTotalValues4Update, assayInspectionTotalValues4Delete);

        if (!assayInspectionTotalValues4Insert.isEmpty())
            assayInspectionTotalValuesService.createAll(assayInspectionTotalValues4Insert);
        if (!assayInspectionTotalValues4Update.isEmpty())
            assayInspectionTotalValuesService.updateAll(assayInspectionTotalValues4Update);
        if (!assayInspectionTotalValues4Delete.getIds().isEmpty())
            assayInspectionTotalValuesService.deleteAll(assayInspectionTotalValues4Delete);
    }

}
