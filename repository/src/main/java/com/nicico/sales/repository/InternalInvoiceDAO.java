package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ViewInternalInvoiceDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InternalInvoiceDAO extends JpaRepository<ViewInternalInvoiceDocument, String>, JpaSpecificationExecutor<ViewInternalInvoiceDocument> {

	@Query("select viid.id from ViewInternalInvoiceDocument viid where viid.invoiceDate like '%1399%'")
	List<String> findAllInvoiceIdsByInvoiceDateContains();

	List<ViewInternalInvoiceDocument> findAllByInvoiceDateContains(String invoiceDate);
}
