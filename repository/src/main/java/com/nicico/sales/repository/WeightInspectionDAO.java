package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.WeightInspection;
import com.nicico.sales.model.enumeration.InspectionReportMilestone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WeightInspectionDAO extends JpaRepository<WeightInspection, Long>, JpaSpecificationExecutor<WeightInspection> {

    List<WeightInspection> findAllByShipmentId(@Param("shipmentId") Long shipmentId);

    List<WeightInspection> findAllByShipmentIdAndInventoryIdIn(@Param("shipmentId") Long shipmentId, @Param("inventoryIds") List<Long> inventoryIds);

    List<WeightInspection> findAllByMileStoneAndInventoryIdIn(@Param("reportMilestoneEnum") InspectionReportMilestone reportMilestoneEnum, @Param("inventoryIds") List<Long> inventoryIds);

}
