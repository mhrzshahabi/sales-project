package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.DailyReportBandarAbbas;
import com.nicico.sales.model.entities.base.myModel.WholeDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WholeDtoDAO extends JpaRepository<WholeDto, Long>, JpaSpecificationExecutor<WholeDto> {
    List<WholeDto> findAllByToDay(String date);

    @Query(value = "select * from TBL_WHOLE_DAily t where T.DESCP = :descp  and T.packing_Type= :packType and T.PLANT = :plant and T.to_Day= :exper  ", nativeQuery = true)
//1398->1397
    WholeDto findAmount(@Param("descp") String descp, @Param("packType") String packType, @Param("plant") String plant, @Param("exper") String exper);

    @Query(value = "select * " +
            " from TBL_WHOLE_DAily w " +
            " WHERE To_char(To_date(w.TO_DAY,'YYYY/MM/DD', 'NLS_CALENDAR=''Gregorian'''),'yyyy/mm/dd') BETWEEN :firstOfMonth and :thisdate   and w.DESCP = :descp  and w.packing_Type= :packType and w.PLANT = :plant  ", nativeQuery = true)
    List<WholeDto> findMonthAndValueBetweenTwoDay(@Param("firstOfMonth") String firstOfMonth, @Param("thisdate") String thisdate, @Param("descp") String descp, @Param("packType") String packType, @Param("plant") String plant);

    @Query(value = "select * from TBL_WHOLE_DAily t where  T.warehouse = :warehouse and T.to_Day= :date",nativeQuery = true)
    List<WholeDto> findByDateAndWarehouse(@Param("date") String date,@Param("warehouse") String warehouse);
    //calculate total count for mes and tahpatil as date and gdsname becuase all of them are tonaj
    @Query(value = " select * from TBL_WHOLE_DAILY r " +
            " where  R.TO_DAY= :date and R.DESCP like %:gdsname%  and R.PACKING_TYPE like %:packtype% " , nativeQuery = true)
    List<WholeDto> findAllByTzn_dateAnAndPMPTYPE_id(@Param("date") String date , @Param("gdsname") String gdsname , @Param("packtype") String packtype);
    //calculate total count for katods  as date and gdsname and packtype becuase some of them are tonaj and others are bandel, bluk

}
