package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractCurrency;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractCurrencyDAO extends JpaRepository<ContractCurrency, Long>, JpaSpecificationExecutor<ContractCurrency> {

}
