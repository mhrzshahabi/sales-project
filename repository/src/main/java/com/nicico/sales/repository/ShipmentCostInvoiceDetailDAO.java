package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.ShipmentCostInvoiceDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentCostInvoiceDetailDAO extends JpaRepository<ShipmentCostInvoiceDetail, Long>, JpaSpecificationExecutor<ShipmentCostInvoiceDetail> {

}
