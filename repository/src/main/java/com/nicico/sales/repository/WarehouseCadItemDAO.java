package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseCadItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WarehouseCadItemDAO extends JpaRepository<WarehouseCadItem, Long>, JpaSpecificationExecutor<WarehouseCadItem> {
    WarehouseCadItem findByWarehouseCadId(Long warehouseCadId);

@Query(value=
		"select i.* from tbl_warehouse_cad c " +
                "join tbl_warehouse_cad_item i on i.warehouse_cad_id=c.id " +
                "where c.material_item_id in (select mi.id  from tbl_material m join tbl_material_item mi on mi.material_id=m.id where m.c_code = ?1 ) " +
                "and i.issue_id is null ", nativeQuery = true)
List<WarehouseCadItem> findOnHandsByHSCode(String hsCode);

}
