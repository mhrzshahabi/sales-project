package com.nicico.sales.service;

import com.nicico.sales.dto.AssayInspectionDTO;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.iservice.IInspectionReportService;
import com.nicico.sales.model.entities.base.AssayInspection;
import com.nicico.sales.model.entities.base.InspectionReport;
import com.nicico.sales.model.entities.base.WeightInspection;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class InspectionReportService extends GenericService<InspectionReport, Long, InspectionReportDTO.Create, InspectionReportDTO.Info, InspectionReportDTO.Update, InspectionReportDTO.Delete> implements IInspectionReportService {

    private final WeightInspectionService weightInspectionService;
    private final AssayInspectionService assayInspectionService;

    @Override
    public InspectionReportDTO.Info createInspec(InspectionReportDTO.Create request) {
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

}
