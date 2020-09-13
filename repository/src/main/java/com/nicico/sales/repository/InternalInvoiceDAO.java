package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ViewInternalInvoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InternalInvoiceDAO extends JpaRepository<ViewInternalInvoice, String>, JpaSpecificationExecutor<ViewInternalInvoice> {

	Optional<ViewInternalInvoice> findByRemittanceId(String remittanceId);

	List<ViewInternalInvoice> findAllByInvoiceDateContains(String invoiceDate);

}
