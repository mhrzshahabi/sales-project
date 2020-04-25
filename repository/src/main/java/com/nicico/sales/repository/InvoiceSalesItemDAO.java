package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.InvoiceSalesItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface InvoiceSalesItemDAO extends JpaRepository<InvoiceSalesItem, Long>, JpaSpecificationExecutor<InvoiceSalesItem> {

}
