package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.AssayInspection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface AssayInspectionDAO extends JpaRepository<AssayInspection, Long>, JpaSpecificationExecutor<AssayInspection> {

}
