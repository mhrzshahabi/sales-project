package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Contract;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractDAO extends JpaRepository<Contract, Long>, JpaSpecificationExecutor<Contract> {
   Contract findById(long id);
}
