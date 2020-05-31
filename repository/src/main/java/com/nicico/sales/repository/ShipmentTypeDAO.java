package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.ShipmentType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ShipmentTypeDAO extends JpaRepository<ShipmentType, Long>, JpaSpecificationExecutor<ShipmentType> {
}
