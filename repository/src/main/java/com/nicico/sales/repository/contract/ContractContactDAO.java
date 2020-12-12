package com.nicico.sales.repository.contract;

import com.nicico.sales.model.entities.contract.ContractContact;
import com.nicico.sales.model.enumeration.CommercialRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContractContactDAO extends JpaRepository<ContractContact, Long>, JpaSpecificationExecutor<ContractContact> {

    Optional<ContractContact> findByContractIdAndContactIdAndCommercialRole(Long contractId, Long contactId, CommercialRole commercialRole);

    List<ContractContact> getByContractId(Long contractId);
}
