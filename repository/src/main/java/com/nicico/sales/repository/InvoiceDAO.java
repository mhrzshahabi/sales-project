package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Invoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceDAO extends JpaRepository<Invoice, Long>, JpaSpecificationExecutor<Invoice> {

    Invoice findByShipmentIdAndInvoiceType(Long id, String provisional);
}
