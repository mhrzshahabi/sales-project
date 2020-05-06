package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractDetailAuditDTO;
import com.nicico.sales.dto.ContractDetailDTO;

import java.util.List;

public interface IContractDetailService {

    ContractDetailDTO.Info get(Long id);

    ContractDetailDTO.Info findByContractID(Long id);

    List<ContractDetailDTO.Info> list();

    ContractDetailDTO.Info FindByContractID(Long id);

    ContractDetailDTO.Info create(ContractDetailDTO.Create request);

    ContractDetailDTO.Info update(Long id, ContractDetailDTO.Update request);

    void delete(Long id);

    void delete(ContractDetailDTO.Delete request);

    TotalResponse<ContractDetailDTO.Info> search(NICICOCriteria criteria);

    TotalResponse<ContractDetailAuditDTO.Info> searchAudit(NICICOCriteria criteria);

}
