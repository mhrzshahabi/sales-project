package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractAuditDTO;

import java.util.List;

public interface IContractAuditService {

    ContractAuditDTO.Info get(Long id);

    List<ContractAuditDTO.Info> list();

    TotalResponse<ContractAuditDTO.Info> search(NICICOCriteria criteria);

}
