package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractShipmentAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractShipmentAuditDAO extends JpaRepository<ContractShipmentAudit, ContractShipmentAudit.ContractShipmentAuditId>, JpaSpecificationExecutor<ContractShipmentAudit> {
}
