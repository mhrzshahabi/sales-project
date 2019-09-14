package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.myModel.ColumnDto;
import com.nicico.sales.model.entities.base.myModel.ReportDetails;

import com.nicico.sales.model.entities.base.myModel.ReportDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportInfoDAO extends JpaRepository<ReportDetails, Long> {




    //5678
    String allReportInfo = " select new com.nicico.sales.model.entities.base.myModel.ReportDto ( 'بندرعباس' as warehouseNo, r.tzn_date , i.GDSNAME ,i.NAMEFA, i.PACKNAME ,r.PMPTYPE_id as pmptypeid ,r.value as wazn, r.loadOrUnload as Isload  )" +
       /* "  , 0 as amountDay, " +
           " 1 as amountImportDay, " +
            " 2  as amountFirstDay , 3 as amountExportDay, 4 as amountReviseDay " +
            ",5 as amountFirstMon ,6 as amountImportMon,7 as amountExportMon ,8 as amountReviseMon, " +
            " 9 as amountFirstSal, 10 as amountImportSal, 11 as amountExportSal,12 as amountReviseSal,13 as reviseSal, 14 as  aa ) " +*/
            // " from TBL_REPORT_INFO r inner join TBL_It.GDSNAMEnterpreter i on r.PMPTYPE_ID=i.P_ID " +
            " from ReportDetails r inner join PMPTYPE i on r.PMPTYPE_id=i.p_id where r.tzn_date = :tznDate " ;
           /* //" inner join TBL_TOZIN_MATERIAL t on t.GDSCODE= i.GDSCODE  " +
            " inner join Material t on t.GDSCODE= i.GDSCODE  " +
            //  " inner join TBL_TOZIN_PLANT p on p.ID= i.PLant_id " +
            " inner join Plant p on p.ID= i.PLANT_ID " +
            //  " inner join TBL_TOZIN_UNIT u on u.ID= i.PACK_TYPE ";
            " inner join Unit u on u.ID= i.PACK_TYPE ";*/

    @Query(value = allReportInfo)
    List<ReportDto> getAllInfoReport(@Param("tznDate") String tznDate);

    String searchpmpttype = " select new com.nicico.sales.model.entities.base.myModel.ColumnDto (  i.GDSNAME, i.NAMEFA, i.PACKNAME ) " +
            "   from  PMPTYPE i where i.p_id = :pgid and i.p_id in (select r.PMPTYPE_id from ReportDetails r )  " ;
     /*       "
      " +*/


    @Query(value = searchpmpttype)
    ColumnDto getsearchpmpttype(@Param("pgid") Long pgid);

    @Query("select new com.nicico.sales.model.entities.base.myModel.ColumnDto (  i.GDSNAME, i.NAMEFA, i.PACKNAME ) from " +
            " PMPTYPE i where i.p_id = :pgid  ")
    ColumnDto getPMPTYpe(@Param("pgid") Long pgid);


/*    @Query(value = "select * from TBL_REPORT_INFO r where r.tzn_date = '1398/01/27' and r.PMPTYPE_id = :pgid and r.LOAD_OR_UNLOAD= :loadunload", nativeQuery = true)
        //  List<Object[]> findLoadInfo(@Param("date") String date, @Param("pgid") Long pgid,@Param("loadunload") int loadOrUnload);
    List<Object> findLoadInfo(@Param("pgid") Long pgid, @Param("loadunload") int loadOrUnload);*/

    @Query(value = "select * from TBL_REPORT_INFO r where r.tzn_date = :tznDate ", nativeQuery = true)
        //  List<Object[]> findLoadInfo(@Param("date") String date, @Param("pgid") Long pgid,@Param("loadunload") int loadOrUnload);
    List<ReportDetails> IfExistenceAnyObjectInDate(@Param("tznDate") String tznDate);

    /*List<ReportDetails> findAllByTz*/


}
