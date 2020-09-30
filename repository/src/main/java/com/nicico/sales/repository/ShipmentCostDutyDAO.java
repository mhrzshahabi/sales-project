package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentCostDuty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentCostDutyDAO extends JpaRepository<ShipmentCostDuty, Long>, JpaSpecificationExecutor<ShipmentCostDuty> {


}
