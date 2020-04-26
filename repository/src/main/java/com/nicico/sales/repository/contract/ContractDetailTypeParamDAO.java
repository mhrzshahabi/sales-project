package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.ContractDetailTypeParam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDetailTypeParamDAO extends JpaRepository<ContractDetailTypeParam, Long>, JpaSpecificationExecutor<ContractDetailTypeParam> {

}
