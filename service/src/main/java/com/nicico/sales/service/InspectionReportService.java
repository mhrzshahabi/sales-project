package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.model.entities.base.InspectionReport;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.repository.AssayInspectionDAO;
import com.nicico.sales.repository.InspectionReportDAO;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

    private final InspectionReportDAO inspectionReportDAO;
    private final WeightInspectionDAO weightInspectionDAO;
    private final AssayInspectionDAO assayInspectionDAO;

    @Override
    public InspectionReportDTO.Info createWeightInspec(InspectionReportDTO.Create request) {

        InspectionReportDTO.Info inspectionReportDTO = super.create(request);
        inspectionReportDTO.setWeightInspection(request.getWeightInspection());

        WeightInspectionDTO.Info weightInspectionDTO = inspectionReportDTO.getWeightInspection();
        weightInspectionDTO.setEditable(true);
        inspectionReportDTO.getWeightInspection().setInspectionReportId(inspectionReportDTO.getId());

        WeightInspection weightInspection = modelMapper.map(weightInspectionDTO, WeightInspection.class);
        weightInspectionDAO.save(weightInspection);

        InspectionReport inspectionReport = modelMapper.map(inspectionReportDTO, InspectionReport.class);
        return save(inspectionReport);


    }
}
