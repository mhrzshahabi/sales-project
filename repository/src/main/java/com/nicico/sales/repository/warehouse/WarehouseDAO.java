package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.Warehouse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseDAO extends JpaRepository<Warehouse, Long>, JpaSpecificationExecutor<Warehouse> {}
