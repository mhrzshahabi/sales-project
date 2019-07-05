package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.BolHeader;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface BolHeaderDAO extends JpaRepository<BolHeader, Long>, JpaSpecificationExecutor<BolHeader> {

}
