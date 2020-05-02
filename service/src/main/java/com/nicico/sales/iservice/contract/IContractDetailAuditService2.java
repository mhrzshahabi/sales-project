package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailAuditDTO2;
import com.nicico.sales.model.entities.common.AuditId;

import java.util.List;

public interface IContractDetailAuditService2 {

    ContractDetailAuditDTO2.Info get(AuditId auditId);

    List<ContractDetailAuditDTO2.Info> getAll(List<AuditId> auditIds);

    List<ContractDetailAuditDTO2.Info> list();

    ContractDetailAuditDTO2.Info create(ContractDetailAuditDTO2.Create request);

    List<ContractDetailAuditDTO2.Info> createAll(List<ContractDetailAuditDTO2.Create> requests);

    ContractDetailAuditDTO2.Info update(ContractDetailAuditDTO2.Update request);

    ContractDetailAuditDTO2.Info update(AuditId auditId, ContractDetailAuditDTO2.Update request);

    List<ContractDetailAuditDTO2.Info> updateAll(List<ContractDetailAuditDTO2.Update> requests);

    List<ContractDetailAuditDTO2.Info> updateAll(List<AuditId> auditIds, List<ContractDetailAuditDTO2.Update> requests);

    void delete(AuditId auditId);

    void deleteAll(ContractDetailAuditDTO2.Delete request);

    TotalResponse<ContractDetailAuditDTO2.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailAuditDTO2.Info> search(SearchDTO.SearchRq request);
}