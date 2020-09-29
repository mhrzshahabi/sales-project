package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.InternalInvoiceDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InternalInvoiceDocumentDAO extends JpaRepository<InternalInvoiceDocument, String>, JpaSpecificationExecutor<InternalInvoiceDocument> {

}
