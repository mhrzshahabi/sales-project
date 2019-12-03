package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WarehouseStockDAO extends JpaRepository<WarehouseStock, Long>, JpaSpecificationExecutor<WarehouseStock> {
    WarehouseStock findByMaterialItemIdAndWarehouseYardIdAndPlantAndWarehouseNo(Long materialItemId, Long warehouseYardId,String plant,String warehouseNo);
    @Query (value="select  s.plant , sum (s.amount) amount  from tbl_material m " +
            "join tbl_material_item mi on mi.material_id=m.id " +
            "join tbl_warehouse_stock s on  s.material_item_id =mi.id " +
            "where m.c_code='26030090' " +
            "group by s.plant ", nativeQuery = true)
    List<Object[]> warehouseStockConc();

    @Query (value="select s.*   from tbl_material m " +
            "join tbl_material_item mi on mi.material_id=m.id " +
            "join tbl_warehouse_stock s on  s.material_item_id =mi.id " +
            "where m.c_code='26030090' ", nativeQuery = true)
    List<WarehouseStock> warehouseStockConcList();

}
