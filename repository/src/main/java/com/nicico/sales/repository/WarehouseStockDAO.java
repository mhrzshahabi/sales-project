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

    @Query(value = "select f8,f7,f6,f5,f4,f3,f2,f1,f0 from (  " +
            "select '1' f,to_char(c.d_created_date,'yyyy/mm/dd','nls_calendar=persian')f0,co.c_name_fa f1,c.amount_draft f2 ,s.vessel_name f3 ,0 f4,(select min(c_descp) from tbl_material where c_code='26030090')f5,s.loading_letter f6 ,  " +
            "       to_char(s.d_created_date,'yyyy/mm/dd','nls_calendar=persian')f7,cr.c_contract_no f8  " +
            "from tbl_warehouse_issue_cons c  " +
            "join tbl_shipment s on s.id=c.shipment_id  " +
            "join tbl_contract cr on cr.contract_id=s.contract_id  " +
            "join tbl_port p on p.id=s.discharge  " +
            "join tbl_country co on co.id=p.country_id  " +
            "  " +
            "union  " +
            "  " +
            "select '2' f,max(f0)f0 ,f1,sum(f2) f2,f3,sum(f4) f4,f5,f6,f7,f8 from (  " +
            "select to_char(c.d_created_date,'yyyy/mm/dd','nls_calendar=persian')f0,co.c_name_fa f1 ,c.AMOUNT_CUSTOM-c.EMPTY_WEIGHT f2,s.vessel_name f3,1 f4 ,(select min(c_descp) from tbl_material where c_code='28257000')f5,s.loading_letter f6,  " +
            "       to_char(s.d_created_date,'yyyy/mm/dd','nls_calendar=persian')f7,cr.c_contract_no f8  " +
            "from tbl_warehouse_issue_mo c  " +
            "join tbl_shipment s on s.id=c.shipment_id  " +
            "join tbl_contract cr on cr.contract_id=s.contract_id  " +
            "join tbl_port p on p.id=s.discharge  " +
            "join tbl_country co on co.id=p.country_id  " +
            ") group by f1,f3,f5,f6,f7,f8  " +
            "  " +
            "union  " +
            "  " +
            "select '3' f,max(f0)f0 ,f1,sum(f2) f2,f3,sum(f4) f4,f5,f6,f7,f8 from (  " +
            "select to_char(c.d_created_date,'yyyy/mm/dd','nls_calendar=persian')f0,co.c_name_fa f1 ,greatest(c.AMOUNT_CUSTOM-c.EMPTY_WEIGHT,c.AMOUNT_PMS) f2,s.vessel_name f3,1 f4 ,(select min(c_descp) from tbl_material where c_code='74031100')f5,s.loading_letter f6,  " +
            "       to_char(s.d_created_date,'yyyy/mm/dd','nls_calendar=persian')f7,cr.c_contract_no f8  " +
            "from TBL_WAREHOUSE_ISSUE_CATHODE c  " +
            "join tbl_shipment s on s.id=c.shipment_id  " +
            "join tbl_contract cr on cr.contract_id=s.contract_id  " +
            "join tbl_port p on p.id=s.discharge  " +
            "join tbl_country co on co.id=p.country_id  " +
            ") group by f1,f3,f5,f6,f7,f8   " +
            "  " +
            ") order by f,f0   ", nativeQuery = true)
    List<Object[]> export(String tillDate);

    @Query(value = "select s.*   from tbl_material m " +
            "join tbl_material_item mi on mi.material_id=m.id " +
            "join tbl_warehouse_stock s on  s.material_item_id =mi.id " +
            "where m.c_code='26030090' ", nativeQuery = true)
    List<WarehouseStock> warehouseStockConcList();

}
