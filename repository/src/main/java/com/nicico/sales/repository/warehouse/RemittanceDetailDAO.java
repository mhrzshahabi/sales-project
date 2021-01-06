package com.nicico.sales.repository.warehouse;

import com.nicico.sales.model.entities.warehouse.RemittanceDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface RemittanceDetailDAO extends JpaRepository<RemittanceDetail, Long>, JpaSpecificationExecutor<RemittanceDetail> {
    List<RemittanceDetail> findAllByRemittanceIdIsIn(List<Long> ids);

    @Query(value = "Select rd.id from  RemittanceDetail rd where rd.remittanceId=:remittance and (rd.sourceTozinId=:tozin or rd.destinationTozinId=:tozin)")
    List<Long> remittanceDetailByWeight(
            @Param("remittance") Long remittance,
            @Param("tozin") Long tozin
    );

    @Query(value = "with initial_criteria as (\n" +
            "    select * from TMP_RD_INV_T where TARGETID = :target_id and FIRST_SOURCEID in :source_id_list\n" +
            "),\n" +
            "     base_on_sum_tmp as (select SUM_WEIGHT SUM_WEIGHT, DAT DAT\n" +
            "                     from initial_criteria\n" +
            "                     where ROWNUM = 1\n" +
            "                       and dat = (select max(DAT)\n" +
            "                                  from initial_criteria\n" +
            "                                  where SUM_WEIGHT < :total_weight)),\n" +
            " base_on_sum_1 as (\n" +
            "         select SUM_WEIGHT, DAT\n" +
            "         from base_on_sum_tmp\n" +
            "         union\n" +
            "         select SUM_WEIGHT, dat\n" +
            "         from (select 0 as SUM_WEIGHT, '0' as dat from dual))\n" +
            "        ,\n" +
            "     base_on_sum as (\n" +
            "         select SUM_WEIGHT, DAT\n" +
            "         from base_on_sum_1\n" +
            "         order by dat desc\n" +
            "             fetch FIRST row only\n" +
            "     )" +
            "     ,remained as (select :total_weight - (select SUM_WEIGHT from base_on_sum) r from dual)\n" +
            "      ,t_20 as (\n" +
            "         select *\n" +
            "         from initial_criteria\n" +
            "         where N_WEIGHT = 20000\n" +
            "           and dat > (select DAT from base_on_sum)\n" +
            "           and ROWNUM <= FLOOR((select r from remained) / 20000))\n" +
            "     ,t_4 as (\n" +
            "         select *\n" +
            "         from initial_criteria\n" +
            "         where N_WEIGHT = 4000\n" +
            "           and dat > (select DAT from base_on_sum)\n" +
            "           and ROWNUM <= FLOOR(mod((select r from remained), 20000) / 4000)),\n" +
            "     t_2 as (\n" +
            "         select *\n" +
            "         from initial_criteria\n" +
            "         where N_WEIGHT = 2000\n" +
            "           and dat > (select DAT from base_on_sum)\n" +
            "           and ROWNUM <= FLOOR(mod((select r from remained), 4000) / 2000)),\n" +
            "     t_1 as (\n" +
            "         select *\n" +
            "         from initial_criteria\n" +
            "         where N_WEIGHT = 1000\n" +
            "           and dat > (select DAT from base_on_sum)\n" +
            "           and ROWNUM <= FLOOR(mod((select r from remained), 2000) / 1000)),\n" +
            "     t_500_k as (\n" +
            "         select *\n" +
            "         from initial_criteria\n" +
            "         where N_WEIGHT = 500\n" +
            "           and dat > (select DAT from base_on_sum)\n" +
            "           and ROWNUM <= FLOOR(mod((select r from remained), 1000) / 500)),\n" +
            "     under_500_1 as (select *\n" +
            "                     from initial_criteria\n" +
            "                     where dat > (select dat from base_on_sum)\n" +
            "                       and N_WEIGHT <= mod((select r from remained), 500)\n" +
            "                     order by N_WEIGHT desc),\n" +
            "     under_500_2 as (select *\n" +
            "                     from initial_criteria\n" +
            "                     where dat > (select dat from base_on_sum)\n" +
            "                       and ID != (select id from under_500_1 where ROWNUM = 1)\n" +
            "                       and N_WEIGHT <=\n" +
            "                           mod((select r from remained), 500) - (select N_WEIGHT from under_500_1 where ROWNUM = 1)\n" +
            "                     order by N_WEIGHT desc),\n" +
            "     under_500_3 as (select *\n" +
            "                     from initial_criteria\n" +
            "                     where dat > (select dat from base_on_sum)\n" +
            "                       and ID != (select id from under_500_1 where ROWNUM = 1)\n" +
            "                       and ID != (select id from under_500_2 where ROWNUM = 1)\n" +
            "                       and N_WEIGHT <=\n" +
            "                           mod((select r from remained), 500) - (select N_WEIGHT from under_500_1 where ROWNUM = 1) -\n" +
            "                           (select N_WEIGHT from under_500_2 where ROWNUM = 1)\n" +
            "                     order by N_WEIGHT desc)\n" +
            "        ,\n" +
            "     result as (\n" +
            "         select *\n" +
            "         from under_500_1\n" +
            "         where ROWNUM = 1\n" +
            "         union\n" +
            "         select *\n" +
            "         from under_500_2\n" +
            "         where ROWNUM = 1\n" +
            "         union\n" +
            "         select *\n" +
            "         from under_500_3\n" +
            "         where ROWNUM = 1\n" +
            "         union\n" +
            "         select *\n" +
            "         from initial_criteria\n" +
            "         where DAT <= (select dat from base_on_sum)\n" +
            "         union\n" +
            "         select *\n" +
            "         from t_20\n" +
            "         union\n" +
            "         select *\n" +
            "         from t_4\n" +
            "         union\n" +
            "         select *\n" +
            "         from t_2\n" +
            "         union\n" +
            "         select *\n" +
            "         from t_1\n" +
            "         union\n" +
            "         select *\n" +
            "         from t_500_k\n" +
            "     )" +
            "select count(*),sum(n_weight) from result", nativeQuery = true)
    List<List<Long>> remittanceDetailByWeightCount(@Param("total_weight") Long weight,
                                                   @Param("source_id_list") List<Long> sourceIdList,
                                                   @Param("target_id") Long targetId)

            ;

    void deleteAllByIdIn(List<Long> ids);
}
