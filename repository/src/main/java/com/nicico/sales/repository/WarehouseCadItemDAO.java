package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseCadItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseCadItemDAO extends JpaRepository<WarehouseCadItem, Long>, JpaSpecificationExecutor<WarehouseCadItem> {
    WarehouseCadItem findByWarehouseCadId(Long warehouseCadId);
}
