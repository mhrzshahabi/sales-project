package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.ContractDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDetailDAO extends JpaRepository<ContractDetail, Long>, JpaSpecificationExecutor<ContractDetail> {

}
