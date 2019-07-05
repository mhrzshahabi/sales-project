package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentAssayHeader;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentAssayHeaderDAO extends JpaRepository<ShipmentAssayHeader, Long>, JpaSpecificationExecutor<ShipmentAssayHeader> {

}
