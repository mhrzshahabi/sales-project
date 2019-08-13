package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentContract;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentContractDAO extends JpaRepository<ShipmentContract, Long>, JpaSpecificationExecutor<ShipmentContract> {

}
