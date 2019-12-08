package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseYard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseYardDAO extends JpaRepository<WarehouseYard, Long>, JpaSpecificationExecutor<WarehouseYard> {

}
