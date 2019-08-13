package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.TozinSales;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface TozinSalesDAO extends JpaRepository<TozinSales, Long>, JpaSpecificationExecutor<TozinSales> {

}
