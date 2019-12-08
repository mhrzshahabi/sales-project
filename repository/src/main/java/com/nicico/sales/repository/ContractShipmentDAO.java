package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ContractShipment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContractShipmentDAO extends JpaRepository<ContractShipment, Long>, JpaSpecificationExecutor<ContractShipment> {

    boolean existsByContractId(Long id);

    List<ContractShipment> findBySendDateAndAmountIsNotNull(String s);
}
