package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.MaterialItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaterialItemDAO extends JpaRepository<MaterialItem, Long>, JpaSpecificationExecutor<MaterialItem> {
    MaterialItem findByGdsCode(Long gdsCode);

    @Query(value = "select distinct GDSCODE,GDSNAME  from V_TOZINE_CONTENT_M where GDSCODE not in (" +
            "    select id" +
            "    from TBL_MATERIAL_ITEM" +
            "    )", nativeQuery = true)
    List<Object[]> itemsForInsert();

    @Query(value = "select distinct GDSCODE,GDSNAME  from V_TOZINE_CONTENT_M where GDSCODE in (" +
            "    select id" +
            "    from TBL_MATERIAL_ITEM" +
            "    )", nativeQuery = true)
    List<Object[]> itemsForUpdate();
}
