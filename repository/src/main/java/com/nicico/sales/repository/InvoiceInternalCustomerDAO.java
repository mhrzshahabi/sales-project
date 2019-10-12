package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InvoiceInternalCustomer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InvoiceInternalCustomerDAO extends JpaRepository<InvoiceInternalCustomer, Long>, JpaSpecificationExecutor<InvoiceInternalCustomer> {
List<InvoiceInternalCustomer> findAllByCustomerId(String customerId);

}
