package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.LME;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LMEDAO extends JpaRepository<LME, Long>, JpaSpecificationExecutor<LME> {

    @Query("SELECT l FROM LME l WHERE YEAR(l.lmeDate) =:year AND MONTH(l.lmeDate) =:month")
    List<LME> findAllByLmeMonth(@Param("year") Integer year, @Param("month") Integer month);
}
