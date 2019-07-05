package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentPrice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentPriceDAO extends JpaRepository<ShipmentPrice, Long>, JpaSpecificationExecutor<ShipmentPrice> {

}
