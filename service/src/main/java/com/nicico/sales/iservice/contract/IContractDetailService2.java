package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailDTO2;
import com.nicico.sales.enumeration.EContractDetailTypeCode;

import java.util.List;

public interface IContractDetailService2 {

    ContractDetailDTO2.Info get(Long id);

    ContractDetailDTO2.Info getContractDetailByContractDetailTypeCode(Long contractId,Long materialId, EContractDetailTypeCode typeCode);

    List<ContractDetailDTO2.Info> getAll(List<Long> ids);

    List<ContractDetailDTO2.Info> list();

    ContractDetailDTO2.Info create(ContractDetailDTO2.Create request);

    List<ContractDetailDTO2.Info> createAll(List<ContractDetailDTO2.Create> requests);

    ContractDetailDTO2.Info update(ContractDetailDTO2.Update request);

    ContractDetailDTO2.Info update(Long id, ContractDetailDTO2.Update request);

    List<ContractDetailDTO2.Info> updateAll(List<ContractDetailDTO2.Update> requests);

    List<ContractDetailDTO2.Info> updateAll(List<Long> ids, List<ContractDetailDTO2.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDetailDTO2.Delete request);

    TotalResponse<ContractDetailDTO2.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailDTO2.Info> search(SearchDTO.SearchRq request);
}
