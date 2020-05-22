package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.IncotermSteps;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IncotermStepsDAO extends JpaRepository<IncotermSteps, Long>, JpaSpecificationExecutor<IncotermSteps> {

    void deleteAllByIncotermId(@Param("incotermId") Long incotermId);
}
