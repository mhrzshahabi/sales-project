package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractDTO2;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.Contract2;

import java.util.List;

public interface IContractService2 extends IGenericService<Contract2, Long, ContractDTO2.Create, ContractDTO2.Info, ContractDTO2.Update, ContractDTO2.Delete> {

    TotalResponse<ContractDTO2.ListGridInfo> refinedSearch(NICICOCriteria request);

    List<Object> getOperationalDataOfContractArticle(Long contractId, String articleCode, String articleKey);
}
