package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.InvoiceType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface InvoiceTypeDAO extends JpaRepository<InvoiceType, Long>, JpaSpecificationExecutor<InvoiceType> {
}
