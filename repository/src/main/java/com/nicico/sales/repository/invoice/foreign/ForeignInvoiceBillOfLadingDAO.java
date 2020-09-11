package com.nicico.sales.repository.invoice.foreign;

import com.nicico.sales.model.entities.invoice.foreign.ForeignInvoiceBillOfLading;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ForeignInvoiceBillOfLadingDAO extends JpaRepository<ForeignInvoiceBillOfLading, Long>, JpaSpecificationExecutor<ForeignInvoiceBillOfLading> {

    List<ForeignInvoiceBillOfLading> findAllByBillOfLandingId(@Param("billOfLandingId") Long billOfLandingId);
}
