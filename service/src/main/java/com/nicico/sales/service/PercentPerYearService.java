package com.nicico.sales.service;

import com.nicico.sales.dto.PercentPerYearDTO;
import com.nicico.sales.iservice.IPercentPerYearService;
import com.nicico.sales.model.entities.base.PercentPerYear;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class PercentPerYearService extends GenericService<PercentPerYear, Long, PercentPerYearDTO, PercentPerYearDTO.Info, PercentPerYearDTO, PercentPerYearDTO> implements IPercentPerYearService {

}
