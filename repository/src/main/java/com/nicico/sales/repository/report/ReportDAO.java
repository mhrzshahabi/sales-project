package com.nicico.sales.repository.report;

import com.nicico.sales.model.entities.report.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportDAO extends JpaRepository<Report, Long>, JpaSpecificationExecutor<Report> {

}
