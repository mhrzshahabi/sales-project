package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentMoistureItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentMoistureItemDAO extends JpaRepository<ShipmentMoistureItem, Long>, JpaSpecificationExecutor<ShipmentMoistureItem> {

}
