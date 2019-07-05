package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ShipmentInquiry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentInquiryDAO extends JpaRepository<ShipmentInquiry, Long>, JpaSpecificationExecutor<ShipmentInquiry> {

}
