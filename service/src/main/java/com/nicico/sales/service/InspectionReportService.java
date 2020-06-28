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
        WeightInspectionDTO.Info weightInspectionDTO = inspectionReportDTO.getWeightInspection();
        weightInspectionDTO.setInspectionReportId(inspectionReportDTO.getId());
        WeightInspection weightInspection = modelMapper.map(weightInspectionDTO, WeightInspection.class);
        weightInspectionDAO.save(weightInspection);

        InspectionReport inspectionReport = modelMapper.map(inspectionReportDTO, InspectionReport.class);
        return save(inspectionReport);

        /*IncotermDTO.Info incoterm = super.create(request);

        List<IncotermSteps> incotermStepsCreateList = new ArrayList<>();
        request.getIncotermSteps().forEach(item -> {
            IncotermSteps incotermSteps = new IncotermSteps();
            incotermSteps.setIncotermStepId(item.getIncotermStepId()).
                    setOrder(item.getOrder()).
                    setIncotermId(incoterm.getId());
            incotermStepsCreateList.add(incotermSteps);
        });
        incotermStepsDAO.saveAll(incotermStepsCreateList);

        request.getIncotermRules().forEach(item -> {
            IncotermRules incotermRules = new IncotermRules();
            incotermRules.setIncotermId(incoterm.getId()).
                    setOrder(item.getOrder()).
                    setIncotermRuleId(item.getIncotermRuleId());
            IncotermRules savedIncotermRules = incotermRulesDAO.save(incotermRules);

            if (item.getIncotermForms() == null || item.getIncotermForms().size() == 0)
                return;

            List<IncotermForms> incotermFormsCreateList = new ArrayList<>();
            item.getIncotermForms().forEach(formTuple -> {
                IncotermForms incotermForms = new IncotermForms();
                incotermForms.setIncotermRulesId(savedIncotermRules.getId()).
                        setIncotermFormId(formTuple.getIncotermFormId()).
                        setOrder(formTuple.getOrder());
                incotermFormsCreateList.add(incotermForms);
            });
            incotermFormsDAO.saveAll(incotermFormsCreateList);
        });*/
    }
}
