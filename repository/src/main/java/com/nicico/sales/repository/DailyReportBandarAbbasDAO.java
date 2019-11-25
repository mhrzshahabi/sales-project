package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.DailyReportBandarAbbas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DailyReportBandarAbbasDAO extends JpaRepository<DailyReportBandarAbbas, Long>, JpaSpecificationExecutor<DailyReportBandarAbbas> {
	@Query(value = "  select dr.WAREHOUSE_NO,dr.TO_DAY,m.c_DESCP,dr.PLANT,dr.PACKING_TYPE,dr.AMOUNT_DAY," +
			"dr.AMOUNT_FIRST_DAY,dr.AMOUNT_IMPORT_DAY,dr.AMOUNT_EXPORT_DAY,dr.AMOUNT_REVISE_DAY ," +
			"dr.AMOUNT_FIRST_MON,dr.AMOUNT_IMPORT_MON,dr.AMOUNT_EXPORT_MON,dr.AMOUNT_REVISE_MON ," +
			"dr.AMOUNT_FIRST_SAL,dr.AMOUNT_IMPORT_SAL,dr.AMOUNT_EXPORT_SAL,dr.AMOUNT_REVISE_SAL,dr.REVISE_SAL_PCT,dr.id " +
			" FROM sales.TBL_DAILY_REPORT_BANDARABBAS  dr  " +
			" join sales.tbl_material m on m.id = dr.MATERIAL_ID " +
			"WHERE dr.TO_DAY = ?1 and dr.WAREHOUSE_NO = ?2 order by dr.id "
			, nativeQuery = true)
	List<Object[]> findByDateAndWarehouse(String date, String warehouse);


	//5678
	/*String allReportInfo = " select new com.nicico.sales.model.entities.base.myModel.ReportDto ( 'بندرعباس' as warehouse, r.tzn_date , i.GDSNAME ,i.NAMEFA, i.PACKNAME ,r.PMPTYPE_id as pmptypeid ,r.value as wazn, r.loadOrUnload as Isload  )" +
	 *//* "  , 0 as amountDay, " +
           " 1 as amountImportDay, " +
            " 2  as amountFirstDay , 3 as amountExportDay, 4 as amountReviseDay " +
            ",5 as amountFirstMon ,6 as amountImportMon,7 as amountExportMon ,8 as amountReviseMon, " +
            " 9 as amountFirstSal, 10 as amountImportSal, 11 as amountExportSal,12 as amountReviseSal,13 as reviseSal, 14 as  aa ) " +*//*
            // " from TBL_REPORT_INFO r inner join TBL_It.GDSNAMEnterpreter i on r.PMPTYPE_ID=i.P_ID " +
            " from ReportInfo r inner join PMPTYPE i on r.PMPTYPE_id=i.p_id where r.tzn_date = :tznDate ";
    *//* //" inner join TBL_TOZIN_MATERIAL t on t.GDSCODE= i.GDSCODE  " +
     " inner join Material t on t.GDSCODE= i.GDSCODE  " +
     //  " inner join TBL_TOZIN_PLANT p on p.ID= i.PLant_id " +
     " inner join Plant p on p.ID= i.PLANT_ID " +
     //  " inner join TBL_TOZIN_UNIT u on u.ID= i.PACK_TYPE ";
     " inner join Unit u on u.ID= i.PACK_TYPE ";*//*
    String searchpmpttype = " select new com.nicico.sales.model.entities.base.myModel.ColumnDto (  i.GDSNAME, i.NAMEFA, i.PACKNAME ) " +
            "   from  PMPTYPE i where i.p_id = :pgid and i.p_id in (select r.PMPTYPE_id from ReportInfo r )  ";

    @Query(value = allReportInfo)
    List<ReportDto> getAllInfoReport(@Param("tznDate") String tznDate);*/
}
