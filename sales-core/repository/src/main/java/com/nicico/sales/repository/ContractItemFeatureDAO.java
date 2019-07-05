package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractItemFeature;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ContractItemFeatureDAO extends JpaRepository<ContractItemFeature, Long>, JpaSpecificationExecutor<ContractItemFeature> {

}
