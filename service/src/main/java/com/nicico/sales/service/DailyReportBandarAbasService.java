package com.nicico.sales.service;


import com.nicico.sales.dto.DailyReportBandarAbasDTO;
import com.nicico.sales.iservice.IDailyReportBandarAbasService;
import com.nicico.sales.model.entities.base.DailyReportBandarAbas;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class DailyReportBandarAbasService extends GenericService<DailyReportBandarAbas,
        DailyReportBandarAbas.DailyReportBandAbasId, DailyReportBandarAbasDTO, DailyReportBandarAbasDTO,
        DailyReportBandarAbasDTO, DailyReportBandarAbasDTO> implements IDailyReportBandarAbasService {

 
}