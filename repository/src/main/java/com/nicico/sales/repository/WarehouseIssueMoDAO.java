package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseIssueMo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseIssueMoDAO extends JpaRepository<WarehouseIssueMo, Long>, JpaSpecificationExecutor<WarehouseIssueMo> {

}
