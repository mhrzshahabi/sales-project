package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseStockDAO extends JpaRepository<WarehouseStock, Long>, JpaSpecificationExecutor<WarehouseStock> {
    WarehouseStock findByMaterialItemIdAndWarehouseYardIdAndPlantAndWarehouseNo(Long materialItemId, Long warehouseYardId,String plant,String warehouseNo);
}
