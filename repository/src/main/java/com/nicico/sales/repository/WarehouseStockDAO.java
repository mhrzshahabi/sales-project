package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WarehouseStockDAO extends JpaRepository<WarehouseStock, Long>, JpaSpecificationExecutor<WarehouseStock> {
    WarehouseStock findByMaterialItemIdAndWarehouseYardIdAndPlantAndWarehouseNo(Long materialItemId, Long warehouseYardId, String plant, String warehouseNo);

    @Query(value = "select  s.plant , sum (s.amount) amount  from tbl_material m " +
            "join tbl_material_item mi on mi.material_id=m.id " +
            "join tbl_warehouse_stock s on  s.material_item_id =mi.id " +
            "where m.c_code='26030090' " +
            "group by s.plant ", nativeQuery = true)
    List<Object[]> warehouseStockConc();

    @Query(value = "select c.c_contract_no,m.c_code,m.c_descl,s.amount,s.send_date,ss.id from tbl_contract_shipment s  " +
            "join tbl_contract c on s.contract_id=c.contract_id " +
            "join tbl_material m on m.id= c.material_id " +
            "left join tbl_shipment ss on ss.contract_shipment_id=s.id " +
            "left join tbl_invoice i on i.shipment_id=ss.id and upper(i.invoice_type)='FINAL' " +
            "where s.amount is not null and s.plan like '%A%' and s.send_date>'2019' and s.send_date< ?1 and i.id is null " +
            "order by m.c_descl,s.send_date ", nativeQuery = true)
    List<Object[]> warehouseStockCommitment(String tillDate);

}
