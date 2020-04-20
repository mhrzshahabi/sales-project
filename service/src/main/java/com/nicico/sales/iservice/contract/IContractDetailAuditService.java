package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.contract.ContractDetailAuditDTO;
import com.nicico.sales.model.entities.common.AuditId;

import java.util.List;

public interface IContractDetailAuditService {

    ContractDetailAuditDTO.Info get(AuditId auditId);

    List<ContractDetailAuditDTO.Info> getAll(List<AuditId> auditIds);

    List<ContractDetailAuditDTO.Info> list();

    ContractDetailAuditDTO.Info create(ContractDetailAuditDTO.Create request);

    List<ContractDetailAuditDTO.Info> createAll(List<ContractDetailAuditDTO.Create> requests);

    ContractDetailAuditDTO.Info update(ContractDetailAuditDTO.Update request);

    ContractDetailAuditDTO.Info update(AuditId auditId, ContractDetailAuditDTO.Update request);

    List<ContractDetailAuditDTO.Info> updateAll(List<ContractDetailAuditDTO.Update> requests);

    List<ContractDetailAuditDTO.Info> updateAll(List<AuditId> auditIds, List<ContractDetailAuditDTO.Update> requests);

    void delete(AuditId auditId);

    void deleteAll(ContractDetailAuditDTO.Delete request);

    TotalResponse<ContractDetailAuditDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ContractDetailAuditDTO.Info> search(SearchDTO.SearchRq request);
}