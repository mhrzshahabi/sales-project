package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.ContractDetail2;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDetailDAO2 extends JpaRepository<ContractDetail2, Long>, JpaSpecificationExecutor<ContractDetail2> {

}
