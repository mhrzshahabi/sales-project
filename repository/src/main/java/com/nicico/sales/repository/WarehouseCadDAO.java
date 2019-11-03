package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseCad;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseCadDAO extends JpaRepository<WarehouseCad, Long>, JpaSpecificationExecutor<WarehouseCad> {

}
