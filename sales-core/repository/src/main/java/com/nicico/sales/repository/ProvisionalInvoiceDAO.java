package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.ProvisionalInvoice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ProvisionalInvoiceDAO extends JpaRepository<ProvisionalInvoice, Long>, JpaSpecificationExecutor<ProvisionalInvoice> {

}
