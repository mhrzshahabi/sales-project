package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.AnalysisMo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface AnalysisMoDAO extends JpaRepository<AnalysisMo, Long> , JpaSpecificationExecutor<AnalysisMo> {
}
