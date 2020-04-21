package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractAuditDTO;
import com.nicico.sales.model.entities.common.AuditId;

import java.util.List;

public interface IContractAuditService2 {

    ContractAuditDTO.Info get(AuditId auditId);

    List<ContractAuditDTO.Info> getAll(List<AuditId> auditIds);

    List<ContractAuditDTO.Info> list();

    ContractAuditDTO.Info create(ContractAuditDTO.Create request);

    List<ContractAuditDTO.Info> createAll(List<ContractAuditDTO.Create> requests);

    ContractAuditDTO.Info update(ContractAuditDTO.Update request);

    ContractAuditDTO.Info update(AuditId auditId, ContractAuditDTO.Update request);

    List<ContractAuditDTO.Info> updateAll(List<ContractAuditDTO.Update> requests);

    List<ContractAuditDTO.Info> updateAll(List<AuditId> auditIds, List<ContractAuditDTO.Update> requests);

    void delete(AuditId auditId);

    void deleteAll(ContractAuditDTO.Delete request);

    TotalResponse<ContractAuditDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractAuditDTO.Info> search(SearchDTO.SearchRq request);
}
