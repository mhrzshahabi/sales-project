package com.nicico.sales.service;

import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.model.entities.base.InspectionReport;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.repository.InspectionReportDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

    @Override
    public InspectionReportDTO.Info createWeightInspec(InspectionReportDTO.Create request) {

        InspectionReportDTO.Info inspectionReportDTO = super.create(request);

        WeightInspection weightInspection = new WeightInspection();
        weightInspection.setInspectionReportId(inspectionReportDTO.getId());

        /*request.getIncotermSteps().forEach(item -> {
            IncotermSteps incotermSteps = new IncotermSteps();
            incotermSteps.setIncotermStepId(item.getIncotermStepId()).
                    setOrder(item.getOrder()).
                    setIncotermId(incoterm.getId());
            incotermStepsCreateList.add(incotermSteps);
        });*/

        InspectionReport inspectionReport = modelMapper.map(inspectionReportDTO, InspectionReport.class);
        return save(inspectionReport);
    }
}
