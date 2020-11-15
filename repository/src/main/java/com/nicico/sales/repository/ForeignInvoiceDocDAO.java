package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.ViewForeignInvoiceDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ForeignInvoiceDocDAO extends JpaRepository<ViewForeignInvoiceDocument, ViewForeignInvoiceDocument.ForeignInvoiceId>, JpaSpecificationExecutor<ViewForeignInvoiceDocument> {

	List<ViewForeignInvoiceDocument> findAllByIdFiId(Long fiId);
}
