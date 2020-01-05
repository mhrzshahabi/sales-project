package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.WarehouseLot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface WarehouseLotDAO extends JpaRepository<WarehouseLot, Long>, JpaSpecificationExecutor<WarehouseLot> {
    WarehouseLot findByLotName(String lotName);

    List<WarehouseLot> findByContractId(Long id);

}
