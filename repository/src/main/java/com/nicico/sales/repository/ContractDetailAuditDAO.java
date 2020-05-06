package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractDetailAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ContractDetailAuditDAO extends JpaRepository<ContractDetailAudit, ContractDetailAudit.ContractDetailAuditId>, JpaSpecificationExecutor<ContractDetailAudit> {

    @Query(nativeQuery = true, value = "select * from TBL_CONTRACT_DETAIL_AUD tc where tc.contract_id=?1")
    ContractDetailAudit findByContract_id(long id);

    @Query(nativeQuery = true, value = "select * from TBL_CONTRACT_DETAIL_AUD tc where tc.contract_id=?1")
    Optional<ContractDetailAudit> findByContractId(long id);

}
