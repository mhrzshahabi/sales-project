package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.Warehouse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WarehouseDAO extends JpaRepository<Warehouse, Long>, JpaSpecificationExecutor<Warehouse> {
    @Modifying
    @Query(value = "insert into TBL_WARH_WAREHOUSE (id,NAME,C_CREATED_BY,D_CREATED_DATE,N_VERSION) " +
            "    (select distinct " +
            "                     m_view.TARGETID as id, " +
            "                     m_view.TARGET as name , " +
            "                     'fromView' as c_created_by, " +
            "                     current_date as D_CREATED_DATE, " +
            "                     0 as n_version " +
            "     from V_TOZINE_CONTENT_M m_view where m_view.TARGETID not in ( " +
            "        select id  from TBL_WAREHOUSE " +
            "    ) " +
            "     union " +
            "     select distinct m__view.SOURCEID as id,m__view.SOURCEE as name , " +
            "                     'fromView' as c_created_by, " +
            "                     current_date as D_CREATED_DATE, " +
            "                     0 as n_version " +
            "     from V_TOZINE_CONTENT_M m__view where m__view.SOURCEID not in ( " +
            "        select id from TBL_WAREHOUSE " +
            "    ))", nativeQuery = true)
    void updateFromTozinView();


    @Query(value = "    select distinct " +
            "                     m_view.TARGETID as id, " +
            "                     m_view.TARGET as name  " +
            "     from V_TOZINE_CONTENT_M m_view where m_view.TARGETID  in ( " +
            "        select id  from TBL_WARH_WAREHOUSE " +
            "    ) " +
            "     union " +
            "     select distinct m__view.SOURCEID as id,m__view.SOURCEE as name  " +
            "     from V_TOZINE_CONTENT_M m__view where m__view.SOURCEID  in ( " +
            "        select id from TBL_WARH_WAREHOUSE " +
            "    )", nativeQuery = true)
    List<Object[]> getAllWarehousesFromViewForUpdate();

    @Query(value = "    select distinct " +
            "                     m_view.TARGETID as id, " +
            "                     m_view.TARGET as name  " +
            "     from V_TOZINE_CONTENT_M m_view where m_view.TARGETID not in ( " +
            "        select id  from TBL_WARH_WAREHOUSE " +
            "    ) " +
            "     union " +
            "     select distinct m__view.SOURCEID as id,m__view.SOURCEE as name  " +
            "     from V_TOZINE_CONTENT_M m__view where m__view.SOURCEID not in ( " +
            "        select id from TBL_WARH_WAREHOUSE " +
            "    )", nativeQuery = true)
    List<Object[]> getAllWarehousesFromViewForInsert();
}
