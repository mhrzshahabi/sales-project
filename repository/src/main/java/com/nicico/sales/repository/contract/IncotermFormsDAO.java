package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.IncotermForms;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IncotermFormsDAO extends JpaRepository<IncotermForms, Long>, JpaSpecificationExecutor<IncotermForms> {

    @Query("SELECT forms FROM IncotermForms forms WHERE forms.incotermRules.incotermId =:incotermId")
    List<IncotermForms> findAllByIncotermId(@Param("incotermId") Long incotermId);
}
