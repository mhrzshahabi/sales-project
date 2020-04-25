package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.PercentPerYear;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface PercentPerYearDAO extends JpaRepository<PercentPerYear, Long>, JpaSpecificationExecutor<PercentPerYear> {

}
