package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.ShipmentCostInvoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ShipmentCostInvoiceDAO extends JpaRepository<ShipmentCostInvoice, Long>, JpaSpecificationExecutor<ShipmentCostInvoice> {

    @Query(value = "SELECT SEQ_INVOICE_NO.nextval FROM dual", nativeQuery = true)
    Long findNextInvoiceSequence();
}
