package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Tozin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TozinDAO extends JpaRepository<Tozin, Long>, JpaSpecificationExecutor<Tozin> {
    @Query(value =
            "select s.namefa snamefa,t.namefa,gdsname, case when instr(carname ,'انتينر')>0   then 'ريلی' else 'جاده اي' end car,nvl(sum(wazn),0) wazn,nvl(sum(tedad),0) tedad  " +
                    "from view_tozin t " +
                    "join tbl_tozin_plant s on s.id=substr(SOURCE_PLANT_ID,1,1) " +
                    "join tbl_tozin_plant t on t.id=target_plant_id " +
                    "where substr(TOZINE_ID,1,1)=?2 and tzn_date=?1 and source_plant_id is not null and target_plant_id is not null and substr(source_plant_id,1,1)<>'-' " +
                    "group by SOURCE_PLANT_ID,target_plant_id,s.namefa,t.namefa,gdscode,gdsname,case when instr(carname ,'انتينر')>0  then 'ريلی' else 'جاده اي' end " +
                    "order by SOURCE_PLANT_ID,gdscode ", nativeQuery = true)
    List<Object[]> findTransport2Plants(String date, String plantId);

    @Query(value =
            "select to_char(id)||','||namefa from tbl_tozin_plant order by id   ", nativeQuery = true)
    String[] findPlants();

}
