package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseLot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseLotDAO extends JpaRepository<WarehouseLot, Long>, JpaSpecificationExecutor<WarehouseLot> {
    WarehouseLot findByLotName(String lotName);
}
