package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ViewInternalInvoiceDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InternalInvoiceDAO extends JpaRepository<ViewInternalInvoiceDocument, String>, JpaSpecificationExecutor<ViewInternalInvoiceDocument> {

	Optional<ViewInternalInvoiceDocument> findByRemittanceId(String remittanceId);

	List<ViewInternalInvoiceDocument> findAllByInvoiceDateContains(String invoiceDate);

}
