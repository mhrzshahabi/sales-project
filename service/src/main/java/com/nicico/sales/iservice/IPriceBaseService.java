package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PriceBaseDTO;
import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.model.enumeration.PriceBaseReference;

import java.util.Date;
import java.util.List;

public interface IPriceBaseService {

    PriceBaseDTO.Info get(Long id);

    List<PriceBaseDTO.Info> list();

    PriceBaseDTO.Info create(PriceBaseDTO.Create request);

    PriceBaseDTO.Info update(Long id, PriceBaseDTO.Update request);

    void delete(Long id);

    void deleteAll(PriceBaseDTO.Delete request);

    TotalResponse<PriceBaseDTO.Info> search(NICICOCriteria criteria);

    List<PriceBaseDTO.Info> getAverageOfElementBasePrices(Long contractId, Long financeUnitId, Date sendDate);

    List<PriceBaseDTO.Info> getAverageOfBasePricesByMOAS(Long contractId, Long financeUnitId, List<ContractDetailDataDTO.MOASData> moasData);

//    PriceBaseDTO.Info getAverageOfBasePricesByMOAS(Long materialElementId, Integer moas, PriceBaseReference reference, Date sendDate);
//
//    PriceBaseDTO.Info getAverageOfBasePricesByWorkingDays(Long materialElementId, Integer workingDayBeforeMOAS, Integer workingDayAfterMOAS, PriceBaseReference reference, Date sendDate);

}