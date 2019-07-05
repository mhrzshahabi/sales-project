package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.MaterialFeature;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface MaterialFeatureDAO extends JpaRepository<MaterialFeature, Long>, JpaSpecificationExecutor<MaterialFeature> {

}
