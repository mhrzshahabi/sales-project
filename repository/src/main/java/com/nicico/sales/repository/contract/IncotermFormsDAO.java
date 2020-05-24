package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.IncotermForms;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IncotermFormsDAO extends JpaRepository<IncotermForms, Long>, JpaSpecificationExecutor<IncotermForms> {

    @Query("DELETE FROM IncotermForms forms WHERE forms.incotermRules.incotermId =:incotermId")
    void deleteAllByIncotermId(@Param("incotermId") Long incotermId);
}
