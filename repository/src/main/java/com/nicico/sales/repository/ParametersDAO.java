package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Parameters;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ParametersDAO extends JpaRepository<Parameters, Long>, JpaSpecificationExecutor<Parameters> {

}
