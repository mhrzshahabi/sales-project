package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailTypeDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractDetailType;

public interface IContractDetailTypeService extends IGenericService<ContractDetailType, Long, ContractDetailTypeDTO.Create, ContractDetailTypeDTO.InfoWithoutDetail, ContractDetailTypeDTO.Update, ContractDetailTypeDTO.Delete> {

    TotalResponse<ContractDetailTypeDTO.Info> completeSearch(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailTypeDTO.Info> completeSearch(SearchDTO.SearchRq request);
}