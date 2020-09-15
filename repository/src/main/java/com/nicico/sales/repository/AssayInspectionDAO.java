package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.AssayInspection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AssayInspectionDAO extends JpaRepository<AssayInspection, Long>, JpaSpecificationExecutor<AssayInspection> {

    List<AssayInspection> findAllByShipmentId(@Param("shipmentId") Long shipmentId);

    List<AssayInspection> findAllByShipmentIdAndInventoryIdIn(@Param("shipmentId") Long shipmentId, @Param("inventoryIds") List<Long> inventoryIds);
}
