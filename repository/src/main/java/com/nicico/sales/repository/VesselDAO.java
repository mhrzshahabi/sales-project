package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.Vessel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface VesselDAO extends JpaRepository<Vessel, Long>, JpaSpecificationExecutor<Vessel> {

}
