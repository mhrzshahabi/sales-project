package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Cost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface CostDAO extends JpaRepository<Cost, Long>, JpaSpecificationExecutor<Cost> {

    Cost findByShipmentId(Long id);
}
