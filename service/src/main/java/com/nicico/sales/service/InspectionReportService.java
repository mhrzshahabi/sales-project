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

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

    private final WeightInspectionDAO weightInspectionDAO;
    private final AssayInspectionDAO assayInspectionDAO;

    @Override
    public InspectionReportDTO.Info createWeightInspec(InspectionReportDTO.Create request) {

        InspectionReportDTO.Info inspectionReportDTO = super.create(request);
        inspectionReportDTO.setWeightInspection(request.getWeightInspection());

        WeightInspectionDTO.Info weightInspectionDTO = inspectionReportDTO.getWeightInspection();
        weightInspectionDTO.setEditable(true);
        weightInspectionDTO.setEStatus(new ArrayList<EStatus>() {{
            add(EStatus.Active); }});
        inspectionReportDTO.getWeightInspection().setInspectionReportId(inspectionReportDTO.getId());

        WeightInspection weightInspection = modelMapper.map(weightInspectionDTO, WeightInspection.class);
        weightInspectionDAO.save(weightInspection);

        InspectionReport inspectionReport = modelMapper.map(inspectionReportDTO, InspectionReport.class);
        return save(inspectionReport);

    }

    @Override
    public InspectionReportDTO.Info createAssayInspec(InspectionReportDTO.Create request) {

        InspectionReportDTO.Info inspectionReportDTO = super.create(request);
        inspectionReportDTO.setAssayInspection(request.getAssayInspection());

        AssayInspectionDTO.Info assayInspectionDTO = inspectionReportDTO.getAssayInspection();
        assayInspectionDTO.setEditable(true);
        assayInspectionDTO.setEStatus(new ArrayList<EStatus>() {{
            add(EStatus.Active); }});
        inspectionReportDTO.getAssayInspection().setInspectionReportId(inspectionReportDTO.getId());

        AssayInspection assayInspection = modelMapper.map(assayInspectionDTO, AssayInspection.class);
        assayInspectionDAO.save(assayInspection);

        InspectionReport inspectionReport = modelMapper.map(inspectionReportDTO, InspectionReport.class);
        return save(inspectionReport);

    }
}
