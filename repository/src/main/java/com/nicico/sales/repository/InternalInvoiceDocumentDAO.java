package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InternalInvoiceDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InternalInvoiceDocumentDAO extends JpaRepository<InternalInvoiceDocument, Long>, JpaSpecificationExecutor<InternalInvoiceDocument> {

}
