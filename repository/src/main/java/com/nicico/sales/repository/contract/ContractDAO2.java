package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.Contract2;
import com.nicico.sales.model.enumeration.EStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContractDAO2 extends JpaRepository<Contract2, Long>, JpaSpecificationExecutor<Contract2> {

    @Query(value = "SELECT SEQ_CONTRACT_NO.nextval FROM dual ", nativeQuery = true)
    Long findNextContractSequence();

    List<Contract2> findAllByEStatusAndContractTypeId(@Param("eStatus") List<EStatus> eStatus, @Param("contractTypeId") Long contractTypeId);
    List<Contract2> findAllByParentId(Long parentId);
}
