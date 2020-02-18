package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseCad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface WarehouseCadDAO extends JpaRepository<WarehouseCad, Long>, JpaSpecificationExecutor<WarehouseCad> {

     @Query(value =
            "select c.* from tbl_warehouse_cad c " +
                    "join tbl_warehouse_cad_item i on i.warehouse_cad_id=c.id " +
                    "where c.material_item_id in (select mi.id  from tbl_material m join tbl_material_item mi on mi.material_id=m.id where m.c_code = ?1 ) " +
                    "group by  c.id,c.c_created_by,c.d_created_date,c.c_last_modified_by,c.d_last_modified_date,c.n_version,c.warehouse_no,c.plant,c.weight_kg,c.bijack_no, " +
                    "c.movement_type,c.yard_id,c.source_load_date,c.destination_unload_date,c.container_no,c.rahahan_polomp_no,c.herasat_polomp_no,c.source_bundle_sum,c.source_tozin_plant_id, " +
                    "c.destination_tozin_plant_id,c.destination_bundle_sum,c.source_sheet_sum,c.destination_sheet_sum,c.source_weight,c.destination_weight,c.material_item_id, c.bijak_first_description, c.bijak_second_description  " +
                    "having min(i.issue_id) is null and max(i.issue_id) is null  ", nativeQuery = true)
    List<WarehouseCad> findOnHandsByHSCode(String hsCode);

    Set<WarehouseCad> getAllByMaterialItemId(Long materialItemId);

}
