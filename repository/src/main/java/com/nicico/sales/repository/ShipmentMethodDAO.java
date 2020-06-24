package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.ShipmentMethod;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ShipmentMethodDAO extends JpaRepository<ShipmentMethod, Long>, JpaSpecificationExecutor<ShipmentMethod> {
}
