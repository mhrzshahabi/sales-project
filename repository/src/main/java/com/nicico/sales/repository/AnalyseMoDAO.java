package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.AnalyseMo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface AnalyseMoDAO extends JpaRepository<AnalyseMo , Long> , JpaSpecificationExecutor<AnalyseMo> {
}
