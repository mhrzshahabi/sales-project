package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ViewInvoiceInternal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InvoiceInternalDAO extends JpaRepository<ViewInvoiceInternal, String>, JpaSpecificationExecutor<ViewInvoiceInternal> {

    Optional<ViewInvoiceInternal> findByRemittanceId(String remittanceId);

    List<ViewInvoiceInternal> findAllByInvoiceDateContains(String invoiceDate);

}
