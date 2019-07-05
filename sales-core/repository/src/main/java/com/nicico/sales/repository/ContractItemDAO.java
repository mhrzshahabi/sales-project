package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractItemDAO extends JpaRepository<ContractItem, Long>, JpaSpecificationExecutor<ContractItem> {

}
