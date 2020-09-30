package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.Contract;

import java.util.List;

public interface IContractService extends IGenericService<Contract, Long, ContractDTO.Create, ContractDTO.Info, ContractDTO.Update, ContractDTO.Delete> {

    TotalResponse<ContractDTO.ListGridInfo> refinedSearch(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDTO.ListGridInfo> refinedSearch(SearchDTO.SearchRq request);

    List<Object> getOperationalDataOfContractArticle(Long contractId, String articleCode, String articleKey);
}
