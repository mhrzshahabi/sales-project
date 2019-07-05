package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.BolItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface BolItemDAO extends JpaRepository<BolItem, Long>, JpaSpecificationExecutor<BolItem> {

}
