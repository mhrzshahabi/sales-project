package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InvoiceInternal;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceInternalDAO extends JpaRepository<InvoiceInternal, String>, JpaSpecificationExecutor<InvoiceInternal> {

}
