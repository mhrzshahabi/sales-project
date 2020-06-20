package com.nicico.sales.iservice.invoice.foreign;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDetailDTO;

import java.util.List;

public interface IForeignInvoiceItemDetailService {

    ForeignInvoiceItemDetailDTO.Info get(Long id);

    List<ForeignInvoiceItemDetailDTO.Info> getAll(List<Long> ids);

    List<ForeignInvoiceItemDetailDTO.Info> list();

    ForeignInvoiceItemDetailDTO.Info create(ForeignInvoiceItemDetailDTO.Create request);

    List<ForeignInvoiceItemDetailDTO.Info> createAll(List<ForeignInvoiceItemDetailDTO.Create> requests);

    ForeignInvoiceItemDetailDTO.Info update(ForeignInvoiceItemDetailDTO.Update request);

    ForeignInvoiceItemDetailDTO.Info update(Long id, ForeignInvoiceItemDetailDTO.Update request);

    List<ForeignInvoiceItemDetailDTO.Info> updateAll(List<ForeignInvoiceItemDetailDTO.Update> requests);

    List<ForeignInvoiceItemDetailDTO.Info> updateAll(List<Long> ids, List<ForeignInvoiceItemDetailDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ForeignInvoiceItemDetailDTO.Delete request);

    TotalResponse<ForeignInvoiceItemDetailDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ForeignInvoiceItemDetailDTO.Info> search(SearchDTO.SearchRq request);
}
