package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractAddendum;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractAddendumDAO extends JpaRepository<ContractAddendum, Long>, JpaSpecificationExecutor<ContractAddendum> {

}
