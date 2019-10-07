package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InvoiceItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceItemDAO extends JpaRepository<InvoiceItem, Long>, JpaSpecificationExecutor<InvoiceItem> {

}