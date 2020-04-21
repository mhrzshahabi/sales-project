package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractAuditDTO2;
import com.nicico.sales.model.entities.common.AuditId;

import java.util.List;

public interface IContractAuditService2 {

    ContractAuditDTO2.Info get(AuditId auditId);

    List<ContractAuditDTO2.Info> getAll(List<AuditId> auditIds);

    List<ContractAuditDTO2.Info> list();

    ContractAuditDTO2.Info create(ContractAuditDTO2.Create request);

    List<ContractAuditDTO2.Info> createAll(List<ContractAuditDTO2.Create> requests);

    ContractAuditDTO2.Info update(ContractAuditDTO2.Update request);

    ContractAuditDTO2.Info update(AuditId auditId, ContractAuditDTO2.Update request);

    List<ContractAuditDTO2.Info> updateAll(List<ContractAuditDTO2.Update> requests);

    List<ContractAuditDTO2.Info> updateAll(List<AuditId> auditIds, List<ContractAuditDTO2.Update> requests);

    void delete(AuditId auditId);

    void deleteAll(ContractAuditDTO2.Delete request);

    TotalResponse<ContractAuditDTO2.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractAuditDTO2.Info> search(SearchDTO.SearchRq request);
}