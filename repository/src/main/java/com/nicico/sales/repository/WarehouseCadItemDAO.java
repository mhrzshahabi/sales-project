package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseCadItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WarehouseCadItemDAO extends JpaRepository<WarehouseCadItem, Long>, JpaSpecificationExecutor<WarehouseCadItem> {

    @Query(value =
            "select * from (select rownum rw,i.* from tbl_warehouse_cad c " +
                    "join tbl_warehouse_cad_item i on i.warehouse_cad_id=c.id " +
                    "where c.material_item_id in (select mi.id  from tbl_material m join tbl_material_item mi on mi.material_id=m.id where m.c_code = ?1 ) " +
                    "and i.issue_id is null and ( ?4 is null or instr(bijack_no,?4 )>0  ) and ( ?5 is null or instr(bundle_serial,?5 )>0 ) order by i.id) where rw >= ?2 and rw<=?3 ", nativeQuery = true)
    List<WarehouseCadItem> findOnHandsByHSCode(String hsCode, int startRow, int endRow, String bijack, String bundleSerial);

    @Query(value =
            "select count(1) from tbl_warehouse_cad c " +
                    "join tbl_warehouse_cad_item i on i.warehouse_cad_id=c.id " +
                    "where c.material_item_id in (select mi.id  from tbl_material m join tbl_material_item mi on mi.material_id=m.id where m.c_code = ?1 ) " +
                    "and i.issue_id is null and ( ?2 is null or instr(bijack_no,?2 )>0  ) and ( ?3 is null or instr(bundle_serial,?3 )>0 )  ", nativeQuery = true)
    int findOnHandsByHSCodeCount(String hsCode, String bijack, String bundleSerial);

}
