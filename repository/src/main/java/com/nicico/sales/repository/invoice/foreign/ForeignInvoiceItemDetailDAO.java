package com.nicico.sales.repository.invoice.foreign;

import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceItemDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ForeignInvoiceItemDetailDAO extends JpaRepository<ForeignInvoiceItemDetail, Long>, JpaSpecificationExecutor<ForeignInvoiceItemDetail> {
}
