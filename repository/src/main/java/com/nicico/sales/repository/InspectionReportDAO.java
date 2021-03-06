package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.InspectionReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InspectionReportDAO extends JpaRepository<InspectionReport, Long>, JpaSpecificationExecutor<InspectionReport> {

}
