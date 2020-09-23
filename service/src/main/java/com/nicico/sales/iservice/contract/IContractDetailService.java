package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;

import java.util.List;

public interface IContractDetailService {

    ContractDetailDTO.Info get(Long id);

    ContractDetailDTO.Info getContractDetailByContractDetailTypeCode(Long contractId,Long materialId, EContractDetailTypeCode typeCode);

    List<ContractDetailDTO.Info> getAll(List<Long> ids);

    List<ContractDetailDTO.Info> list();

    ContractDetailDTO.Info create(ContractDetailDTO.Create request);

    List<ContractDetailDTO.Info> createAll(List<ContractDetailDTO.Create> requests);

    ContractDetailDTO.Info update(ContractDetailDTO.Update request);

    ContractDetailDTO.Info update(Long id, ContractDetailDTO.Update request);

    List<ContractDetailDTO.Info> updateAll(List<ContractDetailDTO.Update> requests);

    List<ContractDetailDTO.Info> updateAll(List<Long> ids, List<ContractDetailDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ContractDetailDTO.Delete request);

    TotalResponse<ContractDetailDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailDTO.Info> search(SearchDTO.SearchRq request);
}
