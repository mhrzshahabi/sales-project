package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDTO2;

import java.util.List;

public interface IContractService2 {

    ContractDTO2.Info get(Long id);

    List<ContractDTO2.Info> getAll(List<Long> ids);

    List<ContractDTO2.Info> list();

    ContractDTO2.Info create(ContractDTO2.Create request);

    List<ContractDTO2.Info> createAll(List<ContractDTO2.Create> requests);

    ContractDTO2.Info update(ContractDTO2.Update request);

    ContractDTO2.Info update(Long id, ContractDTO2.Update request);

    List<ContractDTO2.Info> updateAll(List<ContractDTO2.Update> requests);

    List<ContractDTO2.Info> updateAll(List<Long> ids, List<ContractDTO2.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDTO2.Delete request);

    TotalResponse<ContractDTO2.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDTO2.Info> search(SearchDTO.SearchRq request);
    List<Object> getOperationalDataOfContractArticle(Long contractId, String articleCode, String articleKey);



}
