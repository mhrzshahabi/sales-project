package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.ContractAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractAuditDAO extends JpaRepository<ContractAudit, ContractAudit.ContractAuditId>, JpaSpecificationExecutor<ContractAudit> {
}
