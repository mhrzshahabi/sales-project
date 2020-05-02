package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.common.AuditId;
import com.nicico.sales.model.entities.contract.ContractDetailAudit2;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDetailAuditDAO2 extends JpaRepository<ContractDetailAudit2, AuditId>, JpaSpecificationExecutor<ContractDetailAudit2> {

}
