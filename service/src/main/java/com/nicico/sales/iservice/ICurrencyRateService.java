package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.CurrencyRateDTO;

import java.util.List;

public interface ICurrencyRateService {

    CurrencyRateDTO.Info get(Long id);

    List<CurrencyRateDTO.Info> list();

    CurrencyRateDTO.Info create(CurrencyRateDTO.Create request);

    CurrencyRateDTO.Info update(Long id, CurrencyRateDTO.Update request);

    void delete(Long id);

    void delete(CurrencyRateDTO.Delete request);

    TotalResponse<CurrencyRateDTO.Info> search(NICICOCriteria criteria);
}
