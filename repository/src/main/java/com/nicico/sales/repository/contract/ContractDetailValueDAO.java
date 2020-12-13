package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.ContractDetailValue;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContractDetailValueDAO extends JpaRepository<ContractDetailValue, Long>, JpaSpecificationExecutor<ContractDetailValue> {

    @Query("SELECT cdv FROM ContractDetailValue cdv JOIN cdv.contractDetail cd JOIN cd.contractDetailType cdt JOIN cd.contract c WHERE c.id = :contractId AND cdt.code = :contractDetailCode")
    List<ContractDetailValue> findAllByContractIdAndDetailCode(@Param("contractId") Long contractId, @Param("contractDetailCode") String contractDetailCode);

    @Query("SELECT cdv FROM ContractDetailValue cdv JOIN cdv.contractDetail cd JOIN cd.contractDetailType cdt JOIN cd.contract c WHERE c.id = :contractId AND cdt.code = :contractDetailCode AND cdv.key = :contractDetailValueKey")
    List<ContractDetailValue> findAllByContractIdAndDetailCodeAndValueKey(@Param("contractId") Long contractId, @Param("contractDetailCode") String contractDetailCode, @Param("contractDetailValueKey") String contractDetailValueKey);

    List<ContractDetailValue> getByContractDetailId(Long contractDetailId);
}
