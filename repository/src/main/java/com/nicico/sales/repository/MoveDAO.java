package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.myModel.Movement;
import com.nicico.sales.repository.projection.IMovement;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.RowId;
import java.util.List;

@Repository
public interface MoveDAO extends CrudRepository<Movement, RowId> {

    String view_tozin = " select " +
           // " ROW_NUMBER() OVER( ORDER BY k.NAMEFA desc)   AS Row# , " +
            "   m.id as MATERIAL_ID,nvl (v.PACKNAME ,0) as PACKNAME , s.PLANT_ID as spi ,t.PLANT_ID as tpi , v.GDSCODE   " +
            " , v.CONDITION , " +
            " v.TZN_DATE,p.ID ,k.NAMEFA  ,l.namefa snamefa,p.NAMEFA plant,  p.NAMEEN snameen, " +
            " v.GDSNAME, " +
            " case when instr(v.CARNAME ,'انتينر')>0   then 'ريلی' else 'جاده اي' end car  , " +
            " nvl(sum(v.WAZN),0) wazn " +
            ",nvl(sum(v.tedad),0) tedad   " +

            " from v_tozine_content_m v " +
            " join tbl_tozin_material m on m.GDSCODE=v.GDSCODE " +
            " join TBL_TOZIN_PLANT p on p.id=substr(v.TOZINE_ID,1,1) " +
            " left join TBL_TOZIN_TARGET s on s.targetid= v.SOURCEID " +
            " left join TBL_TOZIN_TARGET t on t.targetid=v.targetid " +
            " join sales.tbl_tozin_plant l on l.id=substr( s.plant_id ||'-'||t.plant_id,1,1)  " +
            "    join sales.tbl_tozin_plant k on k.id=t.PLANT_ID  " +
            "  where v.TZN_DATE = :tznDate and  " +
            "   s.plant_id ||'-'||t.plant_id  is not null and t.PLANT_ID is not null and substr( s.plant_id ||'-'||t.plant_id,1,1)<>'-'  " +
            "    group by   v.PACKNAME , " +
            "    v.CONDITION , " +
            "    m.id , v.tzn_date, p.id,p.namefa,p.NAMEEN,k.NAMEFA  ,l.namefa, s.plant_id ,t.PLANT_ID,k.NAMEFA,v.GDSCODE,v.GDSNAME ," +
            "    case when instr(v.CARNAME ,'انتينر')>0  then 'ريلی' else 'جاده اي' end  " +
            "    order by  v.tzn_date,p.id,s.PLANT_ID ,t.PLANT_ID,v.GDSCODE ";


    @Query(value = view_tozin, nativeQuery = true)
    List<IMovement> findMovement(@Param("tznDate") String tznDate);   //List<Sale> findSale(@Param("date") String date);

    //List<Movement> findMovement(@Param("date") String date);   //List<Sale> findSale(@Param("date") String date);
/* {"warehouseNo", "toDay", "descp", "plant", "packingType", "amountDay",
                            "amountImportDay", "amountFirstDay", "amountExportDay", "amountReviseDay",
                            "amountFirstMon", "amountImportMon", "amountExportMon", "amountReviseMon",
                            "amountFirstSal", "amountImportSal", "amountExportSal", "amountReviseSal", "reviseSal", "aa"
                    });*/

    @Query(value = "select * from Tbl_ReportInfo r inner join TBL_Interpreter i on r.  ", nativeQuery = true)
    List<Object[]> findMailResult();
}
