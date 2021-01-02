package com.nicico.sales.iservice.invoice.foreign;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.invoice.foreign.ContractDetailDataDTO;
import com.nicico.sales.dto.invoice.foreign.ForeignInvoiceItemDTO;

import java.util.Date;
import java.util.List;

public interface IForeignInvoiceItemService {

    ForeignInvoiceItemDTO.Info get(Long id);

    List<ForeignInvoiceItemDTO.Info> getAll(List<Long> ids);

    List<ForeignInvoiceItemDTO.Info> list();

    ForeignInvoiceItemDTO.Calc2Data getCalculationMolybdenumData(Long contractId, Date sendDate, Long financeUnitId, Long inspectionAssayDataId, Long inspectionWeightDataId, ContractDetailDataDTO.Info contractDetailDataInfo);

    ForeignInvoiceItemDTO.Info create(ForeignInvoiceItemDTO.Create request);

    List<ForeignInvoiceItemDTO.Info> createAll(List<ForeignInvoiceItemDTO.Create> requests);

    ForeignInvoiceItemDTO.Info update(ForeignInvoiceItemDTO.Update request);

    ForeignInvoiceItemDTO.Info update(Long id, ForeignInvoiceItemDTO.Update request);

    List<ForeignInvoiceItemDTO.Info> updateAll(List<ForeignInvoiceItemDTO.Update> requests);

    List<ForeignInvoiceItemDTO.Info> updateAll(List<Long> ids, List<ForeignInvoiceItemDTO.Update> requests);

    void delete(Long id);

    void deleteAll(ForeignInvoiceItemDTO.Delete request);

    TotalResponse<ForeignInvoiceItemDTO.Info> search(NICICOCriteria request);

    SearchDTO.SearchRs<ForeignInvoiceItemDTO.Info> search(SearchDTO.SearchRq request);
}
