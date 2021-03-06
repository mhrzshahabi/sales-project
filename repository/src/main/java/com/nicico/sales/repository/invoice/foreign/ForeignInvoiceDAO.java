package com.nicico.sales.repository.invoice.foreign;

import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoice;
import io.lettuce.core.dynamic.annotation.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ForeignInvoiceDAO extends JpaRepository<ForeignInvoice, Long>, JpaSpecificationExecutor<ForeignInvoice> {

    List<ForeignInvoice> findAllByShipmentIdAndInvoiceTypeId(@Param("shipmentId") Long shipmentId, @Param("invoiceTypeId") Long invoiceTypeId);

    List<ForeignInvoice> findAllByParentId(@Param("parentId") Long parentId);

}
