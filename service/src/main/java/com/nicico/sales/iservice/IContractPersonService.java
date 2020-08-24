package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractPersonDTO;

import java.util.List;

public interface IContractPersonService {

    ContractPersonDTO.Info get(Long id);

    List<ContractPersonDTO.Info> list();

    ContractPersonDTO.Info create(ContractPersonDTO.Create request);

    ContractPersonDTO.Info update(Long id, ContractPersonDTO.Update request);

    void delete(Long id);

    void deleteAll(ContractPersonDTO.Delete request);

    TotalResponse<ContractPersonDTO.Info> search(NICICOCriteria criteria);
}
