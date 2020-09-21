package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Deduction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface DeductionDAO extends JpaRepository<Deduction, Long>, JpaSpecificationExecutor<Deduction> {
}
