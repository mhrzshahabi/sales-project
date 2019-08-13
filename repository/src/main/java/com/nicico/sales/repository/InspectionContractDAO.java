package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InspectionContract;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InspectionContractDAO extends JpaRepository<InspectionContract, Long>, JpaSpecificationExecutor<InspectionContract> {

}
