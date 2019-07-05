package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractPerson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractPersonDAO extends JpaRepository<ContractPerson, Long>, JpaSpecificationExecutor<ContractPerson> {

}
