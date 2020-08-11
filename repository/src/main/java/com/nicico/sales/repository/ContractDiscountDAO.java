package com.nicico.sales.repository;


import com.nicico.sales.model.entities.contract.ContractDiscount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDiscountDAO extends JpaRepository<ContractDiscount, Long>, JpaSpecificationExecutor<ContractDiscount> {

}
