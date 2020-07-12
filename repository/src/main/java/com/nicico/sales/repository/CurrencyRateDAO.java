package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.CurrencyRate;
import com.nicico.sales.model.enumeration.RateReference;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface CurrencyRateDAO extends JpaRepository<CurrencyRate, Long>, JpaSpecificationExecutor<CurrencyRate> {

    CurrencyRate findByRateReferenceAndDate(@Param("rateReference") RateReference rateReference, @Param("date") Date date);
}
