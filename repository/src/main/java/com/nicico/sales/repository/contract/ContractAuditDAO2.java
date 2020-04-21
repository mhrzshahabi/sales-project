package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractAudit2;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractAuditDAO2 extends JpaRepository<ContractAudit2, AuditId>, JpaSpecificationExecutor<ContractAudit2> {

}
