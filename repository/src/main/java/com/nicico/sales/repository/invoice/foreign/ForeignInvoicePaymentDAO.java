package com.nicico.sales.repository.invoice.foreign;

import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoicePayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ForeignInvoicePaymentDAO extends JpaRepository<ForeignInvoicePayment, Long>, JpaSpecificationExecutor<ForeignInvoicePayment> {
}
