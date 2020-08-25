package com.nicico.sales.iservice.invoice.foreign;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceDTO;

import java.util.List;

public interface IForeignInvoiceService {

    ForeignInvoiceDTO.Info get(Long id);

    List<ForeignInvoiceDTO.Info> getAll(List<Long> ids);

    List<ForeignInvoiceDTO.Info> list();

    ForeignInvoiceDTO.Info create(ForeignInvoiceDTO.Create request);

    List<ForeignInvoiceDTO.Info> createAll(List<ForeignInvoiceDTO.Create> requests);

    ForeignInvoiceDTO.Info update(ForeignInvoiceDTO.Update request);

    ForeignInvoiceDTO.Info update(Long id, ForeignInvoiceDTO.Update request);

    List<ForeignInvoiceDTO.Info> updateAll(List<ForeignInvoiceDTO.Update> requests);

    List<ForeignInvoiceDTO.Info> updateAll(List<Long> ids, List<ForeignInvoiceDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ForeignInvoiceDTO.Delete request);

    TotalResponse<ForeignInvoiceDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ForeignInvoiceDTO.Info> search(SearchDTO.SearchRq request);

    List<ForeignInvoiceDTO.Info> getByContract(Long contractId, Long typeId);

}
