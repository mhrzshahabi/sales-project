package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractCurrencyDTO;

import java.util.List;

public interface IContractCurrencyService {

    ContractCurrencyDTO.Info get(Long id);

    List<ContractCurrencyDTO.Info> list();

    ContractCurrencyDTO.Info create(ContractCurrencyDTO.Create request);

    ContractCurrencyDTO.Info update(Long id, ContractCurrencyDTO.Update request);

    void delete(Long id);

    void delete(ContractCurrencyDTO.Delete request);

    SearchDTO.SearchRs<ContractCurrencyDTO.Info> search(SearchDTO.SearchRq request);

    TotalResponse<ContractCurrencyDTO.Info> search(NICICOCriteria criteria);
}
