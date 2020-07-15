package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.TypicalAssay;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;


public interface TypicalAssayDAO extends JpaRepository<TypicalAssay, Long>, JpaSpecificationExecutor<TypicalAssay> {
}
