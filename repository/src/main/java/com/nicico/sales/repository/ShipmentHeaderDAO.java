package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentHeader;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentHeaderDAO extends JpaRepository<ShipmentHeader, Long>, JpaSpecificationExecutor<ShipmentHeader> {

}