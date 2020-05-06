package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.SalesType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface SalesTypeDAO extends JpaRepository<SalesType, Long>, JpaSpecificationExecutor<SalesType> {

}
