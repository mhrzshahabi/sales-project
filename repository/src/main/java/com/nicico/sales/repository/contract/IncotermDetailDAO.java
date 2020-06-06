package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.IncotermDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IncotermDetailDAO extends JpaRepository<IncotermDetail, Long>, JpaSpecificationExecutor<IncotermDetail> {

    @Query("SELECT COUNT(detail) FROM IncotermDetail detail WHERE detail.incotermSteps.incotermId =:incotermId AND detail.incotermRules.incotermId =:incotermId")
    Long countByIncotermId(@Param("incotermId") Long incotermId);

    @Query("SELECT detail FROM IncotermDetail detail WHERE detail.incotermSteps.incotermId =:incotermId AND detail.incotermRules.incotermId =:incotermId")
    List<IncotermDetail> findAllByIncotermId(@Param("incotermId") Long incotermId);
}
