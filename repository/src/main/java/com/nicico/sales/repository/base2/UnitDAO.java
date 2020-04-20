package com.nicico.sales.repository.base2;

import com.nicico.sales.model.entities.base.Bank;
import com.nicico.sales.model.entities.base2.Unit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface UnitDAO extends JpaRepository<Unit, Long>, JpaSpecificationExecutor<Bank> {

}
