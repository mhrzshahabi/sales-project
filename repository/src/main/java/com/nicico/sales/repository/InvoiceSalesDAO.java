package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.InvoiceSales;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InvoiceSalesDAO extends JpaRepository<InvoiceSales, Long>, JpaSpecificationExecutor<InvoiceSales> {
    List<InvoiceSales> findBySerialOrderByCreatedDateDesc(String serial);
}
