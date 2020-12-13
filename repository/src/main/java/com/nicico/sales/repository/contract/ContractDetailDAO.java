package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.ContractDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContractDetailDAO extends JpaRepository<ContractDetail, Long>, JpaSpecificationExecutor<ContractDetail> {

    @Query("select cd from ContractDetail cd join cd.contractDetailType cdt where cd.contractId = :contractId and cdt.materialId  =:materialId  and cdt.code =:typeCode ")
    Optional<ContractDetail> findByContractDetailType(@Param("contractId") Long contractId, @Param("materialId") Long materialId, @Param("typeCode") String typeCode);

    List<ContractDetail> getByContractId(Long contractId);
}
