package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentMoistureHeader;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentMoistureHeaderDAO extends JpaRepository<ShipmentMoistureHeader, Long>, JpaSpecificationExecutor<ShipmentMoistureHeader> {

}
