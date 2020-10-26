package com.nicico.sales.repository.report;

import com.nicico.sales.model.entities.report.ReportField;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportFieldDAO extends JpaRepository<ReportField, Long>, JpaSpecificationExecutor<ReportField> {

}
