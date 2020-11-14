package com.nicico.sales.repository.report;

import com.nicico.sales.model.entities.report.ReportGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportGroupDAO extends JpaRepository<ReportGroup, Long>, JpaSpecificationExecutor<ReportGroup> {

    @Query(value = "" +
            " SELECT      ID " +
            " FROM        tbl_report_group " +
            " START WITH  ID =:rootId " +
            " CONNECT BY NOCYCLE PRIOR ID = F_PARENT_ID ", nativeQuery = true)
    List<Long> getAllChilds(@Param("rootId") Long rootId);
}
