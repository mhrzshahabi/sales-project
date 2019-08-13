package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentEmail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentEmailDAO extends JpaRepository<ShipmentEmail, Long>, JpaSpecificationExecutor<ShipmentEmail> {

}
