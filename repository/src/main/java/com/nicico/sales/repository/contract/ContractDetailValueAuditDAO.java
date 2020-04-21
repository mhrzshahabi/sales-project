package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractDetailValueAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDetailValueAuditDAO extends JpaRepository<ContractDetailValueAudit, AuditId>, JpaSpecificationExecutor<ContractDetailValueAudit> {

}
