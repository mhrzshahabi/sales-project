package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.Contract2;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDAO2 extends JpaRepository<Contract2, Long>, JpaSpecificationExecutor<Contract2> {

    @Query(value = "SELECT SEQ_CONTRACT_NO.nextval FROM dual ", nativeQuery = true)
    Long findNextContractSequence();
}
