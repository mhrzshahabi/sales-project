package com.nicico.sales.iservice;


import com.nicico.sales.dto.DailyReportBandarAbasDTO;
import com.nicico.sales.model.entities.base.DailyReportBandarAbas;
import org.springframework.stereotype.Repository;

@Repository
public interface IDailyReportBandarAbasService extends IGenericService<DailyReportBandarAbas, DailyReportBandarAbas.DailyReportBandAbasId ,
        DailyReportBandarAbasDTO , DailyReportBandarAbasDTO , DailyReportBandarAbasDTO , DailyReportBandarAbasDTO> {
}
