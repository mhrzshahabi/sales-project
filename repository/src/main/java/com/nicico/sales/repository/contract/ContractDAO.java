package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.Contract;
import com.nicico.sales.model.enumeration.EStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContractDAO extends JpaRepository<Contract, Long>, JpaSpecificationExecutor<Contract> {

    @Query("SELECT c.content FROM Contract c where c.id=:id")
    String getContent(Long id);

    @Query(value = "SELECT SEQ_CONTRACT_NO.nextval FROM dual ", nativeQuery = true)
    Long findNextContractSequence();

    List<Contract> findAllByEStatusAndContractTypeId(@Param("eStatus") List<EStatus> eStatus, @Param("contractTypeId") Long contractTypeId);

    List<Contract> findAllByParentId(Long parentId);

    @Query("select cdt.contract.no from ContractDetail cdt where cdt.contractDetailTypeId=:typeId")
    List<String> findAllByContractDetailTypeId(@Param("typeId") Long typeId);
}
