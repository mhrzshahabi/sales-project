package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.DeductionDTO;

import java.util.List;

public interface IDeductionService {

    DeductionDTO.Info get(Long id);

    List<DeductionDTO.Info> list();

    DeductionDTO.Info create(DeductionDTO.Create request);

    DeductionDTO.Info update(Long id, DeductionDTO.Update request);

    void delete(Long id);

    void deleteAll(DeductionDTO.Delete request);

    TotalResponse<DeductionDTO.Info> search(NICICOCriteria criteria);

}
