package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InvoiceInternalLc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InvoiceInternalLcDAO extends JpaRepository<InvoiceInternalLc, Long>, JpaSpecificationExecutor<InvoiceInternalLc> {
  List  <InvoiceInternalLc> findAllByLcId(String lcid);

}
