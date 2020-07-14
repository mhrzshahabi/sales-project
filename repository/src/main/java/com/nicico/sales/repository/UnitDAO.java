package com.nicico.sales.repository;



import com.nicico.sales.model.entities.base.Unit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UnitDAO extends JpaRepository<Unit, Long>, JpaSpecificationExecutor<Unit> {

    void deleteAllByCreatedByIs(String createdBy);

    @Query(value = "select distinct UNIT_KALA, PACKNAME from V_TOZINE_CONTENT_M " +
            "where unit_kala is not null and UNIT_KALA  in " +
            "(select ID from TBL_UNIT) order by unit_kala asc", nativeQuery = true)
    List<Object[]> getAllUnitsFromViewForUpdate();

    @Query(value = "select distinct UNIT_KALA," +
            "             PACKNAME from V_TOZINE_CONTENT_M where unit_kala is not null" +
            "             and UNIT_KALA NOT in (select ID from TBL_UNIT) order by unit_kala asc", nativeQuery = true)
    List<Object[]> getAllUnitsFromViewForInsert();
}
