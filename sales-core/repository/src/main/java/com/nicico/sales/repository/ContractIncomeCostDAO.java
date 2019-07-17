package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractIncomeCost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractIncomeCostDAO extends JpaRepository<ContractIncomeCost, Long>, JpaSpecificationExecutor<ContractIncomeCost> {

}
