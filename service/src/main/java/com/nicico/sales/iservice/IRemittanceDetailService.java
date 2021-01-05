package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.RemittanceDetailDTO;
import com.nicico.sales.model.entities.warehouse.RemittanceDetail;

import java.util.List;

public interface IRemittanceDetailService extends IGenericService<RemittanceDetail, Long, RemittanceDetailDTO.Create, RemittanceDetailDTO.Info, RemittanceDetailDTO.Update, RemittanceDetailDTO.Delete> {
    List<RemittanceDetailDTO.Info> batchUpdate(RemittanceDetailDTO.WithRemittanceAndInventory request);

    List<RemittanceDetailDTO.Info> out(RemittanceDetailDTO.OutRemittance request);
    List<Long> outWeight(RemittanceDetailDTO.OutRemittanceWeight request);

    TotalResponse<RemittanceDetailDTO.ReportInfo> reportSearch(NICICOCriteria nicicoCriteria);

    SearchDTO.SearchRs<RemittanceDetailDTO.ReportInfo> reportSearch(SearchDTO.SearchRq request);
}
