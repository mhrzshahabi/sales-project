package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.entities.base.InspectionReport;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.enumeration.EStatus;
import com.nicico.sales.repository.AssayInspectionDAO;
import com.nicico.sales.repository.InspectionReportDAO;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

    private final WeightInspectionDAO weightInspectionDAO;
    private final AssayInspectionDAO assayInspectionDAO;
    private final WeightInspectionService weightInspectionService;

    @Override
    public InspectionReportDTO.Info createWeightInspec(InspectionReportDTO.Create request) {
        List<WeightInspectionDTO.Create> weightInspections = request.getWeightInspections();
//        List<AssayInspectionDTO.Create> assayInspections = request.getAssayInspections();

        request.setWeightInspections(null);
//        request.setAssayInspections(null);

        InspectionReportDTO.Info inspectionReportDTO = super.create(request);

        weightInspections.forEach(item->item.setInspectionReportId(inspectionReportDTO.getId()));
//        assayInspections.forEach(item->item.setInspectionReportId(inspectionReportDTO.getId()));

        weightInspections.forEach(item -> {
            WeightInspection weightInspection = modelMapper.map(item, WeightInspection.class);
            weightInspectionService.save(weightInspection);
        });

// #################################################################################
//        IncotermDTO.Info incoterm = super.create(request);

//        List<IncotermSteps> incotermStepsCreateList = new ArrayList<>();
//        request.getIncotermSteps().forEach(item -> {
//            IncotermSteps incotermSteps = new IncotermSteps();
//            incotermSteps.setIncotermStepId(item.getIncotermStepId()).
//                    setOrder(item.getOrder()).
//                    setIncotermId(incoterm.getId());
//            incotermStepsCreateList.add(incotermSteps);
//        });
//        incotermStepsDAO.saveAll(incotermStepsCreateList);
        return null;

    }

    @Override
    public InspectionReportDTO.Info createAssayInspec(InspectionReportDTO.Create request) {

        /*InspectionReportDTO.Info inspectionReportDTO = super.create(request);
        inspectionReportDTO.setAssayInspection(request.getAssayInspection());

        AssayInspectionDTO.Info assayInspectionDTO = inspectionReportDTO.getAssayInspection();
        assayInspectionDTO.setEditable(true);
        assayInspectionDTO.setEStatus(new ArrayList<EStatus>() {{
            add(EStatus.Active); }});
        inspectionReportDTO.getAssayInspection().setInspectionReportId(inspectionReportDTO.getId());

        AssayInspection assayInspection = modelMapper.map(assayInspectionDTO, AssayInspection.class);
        assayInspectionDAO.save(assayInspection);

        InspectionReport inspectionReport = modelMapper.map(inspectionReportDTO, InspectionReport.class);
        return save(inspectionReport);*/
        return null;

    }
}
