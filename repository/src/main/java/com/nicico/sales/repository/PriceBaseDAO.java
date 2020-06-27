package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.PriceBase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PriceBaseDAO extends JpaRepository<PriceBase, Long>, JpaSpecificationExecutor<PriceBase> {

    @Query("SELECT p FROM PriceBase p WHERE YEAR(p.priceDate) =:year AND MONTH(p.priceDate) =:month")
    List<PriceBase> findAllByPriceBaseMonth(@Param("year") Integer year, @Param("month") Integer month);
}
