package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Unit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UnitDAO extends JpaRepository<Unit, Long>, JpaSpecificationExecutor<Unit> {

    void deleteAllByCreatedByIs(String createdBy);

    @Modifying
    @Query(value = " insert into TBL_UNIT (ID,C_NAME_FA, C_CREATED_BY,   N_VERSION) select distinct UNIT_KALA, " +
            " PACKNAME, 'fromView', 0 from n_master.V_TOZINE_CONTENT_M where unit_kala is not null " +
            " order by unit_kala asc", nativeQuery = true)
    void updateUnitsFromTozinView();
}
