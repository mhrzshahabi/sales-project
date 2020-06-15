package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ItemDAO extends JpaRepository<Item, Long>, JpaSpecificationExecutor<Item> {
    @Query(value = "select distinct GDSCODE,GDSNAME  from n_master.V_TOZINE_CONTENT_M where GDSCODE not in (" +
            "    select id" +
            "    from TBL_WARH_ITEM" +
            "    )", nativeQuery = true)
    List<Object[]> itemsForInsert();

    @Query(value = "select distinct GDSCODE,GDSNAME  from n_master.V_TOZINE_CONTENT_M where GDSCODE in (" +
            "    select id" +
            "    from TBL_WARH_ITEM" +
            "    )", nativeQuery = true)
    List<Object[]> itemsForUpdate();
}
