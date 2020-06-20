package com.nicico.sales.iservice.invoice.foreign;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoicePaymentDTO;

import java.util.List;

public interface IForeignInvoicePaymentService {

    ForeignInvoicePaymentDTO.Info get(Long id);

    List<ForeignInvoicePaymentDTO.Info> getAll(List<Long> ids);

    List<ForeignInvoicePaymentDTO.Info> list();

    ForeignInvoicePaymentDTO.Info create(ForeignInvoicePaymentDTO.Create request);

    List<ForeignInvoicePaymentDTO.Info> createAll(List<ForeignInvoicePaymentDTO.Create> requests);

    ForeignInvoicePaymentDTO.Info update(ForeignInvoicePaymentDTO.Update request);

    ForeignInvoicePaymentDTO.Info update(Long id, ForeignInvoicePaymentDTO.Update request);

    List<ForeignInvoicePaymentDTO.Info> updateAll(List<ForeignInvoicePaymentDTO.Update> requests);

    List<ForeignInvoicePaymentDTO.Info> updateAll(List<Long> ids, List<ForeignInvoicePaymentDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ForeignInvoicePaymentDTO.Delete request);

    TotalResponse<ForeignInvoicePaymentDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ForeignInvoicePaymentDTO.Info> search(SearchDTO.SearchRq request);
}
