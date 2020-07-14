package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.entities.base.InspectionReport;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.utility.UpdateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

    private final WeightInspectionService weightInspectionService;
    private final AssayInspectionService assayInspectionService;
    private final UpdateUtil updateUtil;
    private final ResourceBundleMessageSource messageSource;

    @Override
    @Transactional
    @Action(ActionType.Create)
    public InspectionReportDTO.Info create(InspectionReportDTO.Create request) {
        List<WeightInspectionDTO.Create> weightInspections = request.getWeightInspections();
        List<List<AssayInspectionDTO.Create>> assayInspections = request.getAssayInspections();

        request.setWeightInspections(null);
        request.setAssayInspections(null);

        InspectionReportDTO.Info inspectionReportDTO = super.create(request);

        weightInspections.forEach(item -> item.setInspectionReportId(inspectionReportDTO.getId()));

        assayInspections.forEach(record -> {
            record.forEach(obj -> {
                obj.setInspectionReportId(inspectionReportDTO.getId());
                AssayInspection assayInspection = modelMapper.map(obj, AssayInspection.class);
                assayInspectionService.save(assayInspection);
            });
        });

        weightInspections.forEach(item -> {
            WeightInspection weightInspection = modelMapper.map(item, WeightInspection.class);
            weightInspectionService.save(weightInspection);
        });

        return inspectionReportDTO;
    }

    @Override
    @Transactional
    @Action(value = ActionType.Update)
    public InspectionReportDTO.Info update(Long id, InspectionReportDTO.Update request) {

        InspectionReport inspectionReport = repository.findById(id).orElseThrow(() -> new NotFoundException(InspectionReport.class));

        try {

            updateWeight(request, inspectionReport);
            updateAssay(request, inspectionReport);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchFieldException e) {

            Locale locale = LocaleContextHolder.getLocale();
            throw new SalesException2(ErrorType.Unknown, "", messageSource.getMessage("contract-detail-type.exception.update", null, locale));
        }

        InspectionReport updating = new InspectionReport();
        modelMapper.map(inspectionReport, updating);
        modelMapper.map(request, updating);
        validation(updating, request);

        return save(updating);
    }

    private void updateWeight(InspectionReportDTO.Update request, InspectionReport inspectionReport) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<WeightInspectionDTO.Create> weightInspection4Insert = new ArrayList<>();
        List<WeightInspectionDTO.Update> weightInspection4Update = new ArrayList<>();
        WeightInspectionDTO.Delete weightInspection4Delete = new WeightInspectionDTO.Delete();

        updateUtil.fill(
                WeightInspection.class,
                inspectionReport.getWeightInspections(),
                WeightInspectionDTO.Info.class,
                request.getWeightInspections(),
                WeightInspectionDTO.Create.class,
                weightInspection4Insert,
                WeightInspectionDTO.Update.class,
                weightInspection4Update,
                weightInspection4Delete);

        if (!weightInspection4Insert.isEmpty())
            weightInspectionService.createAll(weightInspection4Insert);
        if (!weightInspection4Update.isEmpty())
            weightInspectionService.updateAll(weightInspection4Update);
        if (!weightInspection4Delete.getIds().isEmpty())
            weightInspectionService.deleteAll(weightInspection4Delete);
    }

    private void updateAssay(InspectionReportDTO.Update request, InspectionReport inspectionReport) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        List<AssayInspectionDTO.Create> assayInspection4Insert = new ArrayList<>();
        List<AssayInspectionDTO.Update> assayInspection4Update = new ArrayList<>();
        AssayInspectionDTO.Delete assayInspection4Delete = new AssayInspectionDTO.Delete();

        updateUtil.fill(
                AssayInspection.class,
                inspectionReport.getAssayInspections(),
                AssayInspectionDTO.Info.class,
                request.getAssayInspections(),
                AssayInspectionDTO.Create.class,
                assayInspection4Insert,
                AssayInspectionDTO.Update.class,
                assayInspection4Update,
                assayInspection4Delete);

        if (!assayInspection4Insert.isEmpty())
            assayInspectionService.createAll(assayInspection4Insert);
        if (!assayInspection4Update.isEmpty())
            assayInspectionService.updateAll(assayInspection4Update);
        if (!assayInspection4Delete.getIds().isEmpty())
            assayInspectionService.deleteAll(assayInspection4Delete);
    }

}
