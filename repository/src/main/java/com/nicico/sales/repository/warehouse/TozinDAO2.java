package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.Tozin2;
import com.nicico.sales.model.entities.warehouse.TozinId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface TozinDAO2 extends JpaRepository<Tozin2, TozinId>, JpaSpecificationExecutor<Tozin2> {
//    List<Tozin2> findByIdTozinId(String tozinId);

    @Query("from Tozin2 t where t.Id.tozinId in (:tozinId)")
    List<Tozin2> findAllByTozinIdList(@Param("tozinId") List<String> tozinId);

    @Query(value = "select * FROM TBL_TOZIN_TARGET", nativeQuery = true)
    List<Map> listTargets();
}
