package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.ContractDetail2;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ContractDetailDAO2 extends JpaRepository<ContractDetail2, Long>, JpaSpecificationExecutor<ContractDetail2> {

    @Query("select cd from ContractDetail2 cd join cd.contractDetailType cdt where cd.contractId = :contractId and cdt.code =:typeCode and cdt.materialId  =:materialId ")
    Optional<ContractDetail2> findByContractDetailType(@Param("contractId") Long contractId,@Param("materialId") Long materialId , @Param("typeCode") String typeCode);
}
