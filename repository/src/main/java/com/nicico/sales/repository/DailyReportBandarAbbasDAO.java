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
}
