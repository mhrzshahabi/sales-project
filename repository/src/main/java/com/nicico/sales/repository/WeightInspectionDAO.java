package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.WeightInspection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WeightInspectionDAO extends JpaRepository<WeightInspection, Long>, JpaSpecificationExecutor<WeightInspection> {

    List<WeightInspection> findAllByInventoryId(@Param("inventoryIds") List<Long> inventoryIds);
}
