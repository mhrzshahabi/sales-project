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

}
