package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Feature;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface FeatureDAO extends JpaRepository<Feature, Long>, JpaSpecificationExecutor<Feature> {

}
