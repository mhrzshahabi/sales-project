package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.InspectionReportDTO;
import com.nicico.sales.dto.WeightInspectionDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.iservice.IWeightInspectionService;
import com.nicico.sales.model.entities.base.InspectionReport;
import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.repository.InspectionReportDAO;
import com.nicico.sales.repository.WeightInspectionDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@RequiredArgsConstructor
@Service
public class WeightInspectionService extends GenericService<WeightInspection, Long, WeightInspectionDTO.Create, WeightInspectionDTO.Info, WeightInspectionDTO.Update, WeightInspectionDTO.Delete> implements IWeightInspectionService {

    private final WeightInspectionDAO weightInspectionDAO;
    private final InspectionReportDAO inspectionReportDAO;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    @Action(value = ActionType.Create, authority = "")
    public WeightInspectionDTO.Info createWeightInspec(WeightInspectionDTO.Create request) {

        WeightInspectionDTO.Info weightInspectionDTO = super.create(request);


        InspectionReportDTO.Info inspectionReportDTO = new InspectionReportDTO.Info();
        inspectionReportDTO.setInspectionNO(weightInspectionDTO.getInspectionReport().getInspectionNO());
        inspectionReportDTO.setInspectorId(weightInspectionDTO.getInspectionReport().getInspectorId());
        inspectionReportDTO.setInspectionPlace(weightInspectionDTO.getInspectionReport().getInspectionPlace());
        inspectionReportDTO.setIssueDate(weightInspectionDTO.getInspectionReport().getIssueDate());
        inspectionReportDTO.setInventoryId(weightInspectionDTO.getInspectionReport().getInventoryId());
        inspectionReportDTO.setSellerId(weightInspectionDTO.getInspectionReport().getSellerId());
        inspectionReportDTO.setBuyerId(weightInspectionDTO.getInspectionReport().getBuyerId());
        inspectionReportDTO.setInspectionRateValue(weightInspectionDTO.getInspectionReport().getInspectionRateValue());
        inspectionReportDTO.setInspectionRateValueType(weightInspectionDTO.getInspectionReport().getInspectionRateValueType());
        inspectionReportDTO.setCurrencyId(weightInspectionDTO.getInspectionReport().getCurrencyId());
        inspectionReportDTO.setCurrencyId(weightInspectionDTO.getInspectionReport().getCurrencyId());


        weightInspectionDTO.setInspectionReport(inspectionReportDTO);
        WeightInspection weightInspection = modelMapper.map(weightInspectionDTO, WeightInspection.class);
        return save(weightInspection);

    }
}
