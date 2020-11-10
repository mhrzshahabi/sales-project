package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.PriceBase;
import com.nicico.sales.model.enumeration.PriceBaseReference;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Repository
public interface PriceBaseDAO extends JpaRepository<PriceBase, Long>, JpaSpecificationExecutor<PriceBase> {

    @Query("SELECT p FROM PriceBase p WHERE p.priceBaseReference =:reference AND YEAR(p.priceDate) =:year AND MONTH(p.priceDate) =:month AND p.elementId =:elementId")
    List<PriceBase> getAllPricesByElements(@Param("reference") PriceBaseReference reference, @Param("year") Integer year, @Param("month") Integer month, @Param("elementId") Long elementId);

    @Query("SELECT p FROM PriceBase p WHERE p.priceBaseReference =:reference AND TO_CHAR(p.priceDate, 'YYYY-MM-DD') IN :workingDays AND p.elementId =:elementId")
    List<PriceBase> getAllPricesByElements(@Param("reference") PriceBaseReference reference, @Param("workingDays") List<String> workingDays, @Param("elementId") Long elementId);
}
