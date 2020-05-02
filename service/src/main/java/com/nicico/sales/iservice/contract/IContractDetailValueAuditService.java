package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailValueAuditDTO;
import com.nicico.sales.model.entities.common.AuditId;

import java.util.List;

public interface IContractDetailValueAuditService {

    ContractDetailValueAuditDTO.Info get(AuditId auditId);

    List<ContractDetailValueAuditDTO.Info> getAll(List<AuditId> auditIds);

    List<ContractDetailValueAuditDTO.Info> list();

    ContractDetailValueAuditDTO.Info create(ContractDetailValueAuditDTO.Create request);

    List<ContractDetailValueAuditDTO.Info> createAll(List<ContractDetailValueAuditDTO.Create> requests);

    ContractDetailValueAuditDTO.Info update(ContractDetailValueAuditDTO.Update request);

    ContractDetailValueAuditDTO.Info update(AuditId auditId, ContractDetailValueAuditDTO.Update request);

    List<ContractDetailValueAuditDTO.Info> updateAll(List<ContractDetailValueAuditDTO.Update> requests);

    List<ContractDetailValueAuditDTO.Info> updateAll(List<AuditId> auditIds, List<ContractDetailValueAuditDTO.Update> requests);

    void delete(AuditId auditId);

    void deleteAll(ContractDetailValueAuditDTO.Delete request);

    TotalResponse<ContractDetailValueAuditDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailValueAuditDTO.Info> search(SearchDTO.SearchRq request);
}