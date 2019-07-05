package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractItemAddendum;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractItemAddendumDAO extends JpaRepository<ContractItemAddendum, Long>, JpaSpecificationExecutor<ContractItemAddendum> {

}
