package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.myModel.ColumnDto;
import com.nicico.sales.model.entities.base.myModel.ReportDto;
import com.nicico.sales.model.entities.base.myModel.ReportInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportInfoDAO extends JpaRepository<ReportInfo, Long> {

//    List<ReportDto> getAllInfoReport(String tznDate);

//    ColumnDto getsearchpmpttype(Long pgid);

    @Query("select new com.nicico.sales.model.entities.base.myModel.ColumnDto (  i.GDSNAME, i.NAMEFA, i.PACKNAME ) from " +
            " PMPTYPE i where i.p_id = :pgid  ")
    ColumnDto getPMPTYpe(@Param("pgid") Long pgid);

    @Query(value = "select * from TBL_REPORT_INFO r where r.tzn_date = :tznDate ", nativeQuery = true)
    List<ReportInfo> IfExistenceAnyObjectInDate(@Param("tznDate") String tznDate);
}
