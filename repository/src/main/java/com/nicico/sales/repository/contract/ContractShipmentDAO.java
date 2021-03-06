package com.nicico.sales.repository.contract;


import com.nicico.sales.model.entities.contract.ContractShipment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContractShipmentDAO extends JpaRepository<ContractShipment, Long>, JpaSpecificationExecutor<ContractShipment> {
    List<ContractShipment> findByContractId(long id);
}
