package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InvoiceMolybdenum;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceMolybdenumDAO extends JpaRepository<InvoiceMolybdenum, Long>, JpaSpecificationExecutor<InvoiceMolybdenum> {

}
