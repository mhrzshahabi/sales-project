package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.IncotermRule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface IncotermRuleDAO extends JpaRepository<IncotermRule, Long>, JpaSpecificationExecutor<IncotermRule> {

}
