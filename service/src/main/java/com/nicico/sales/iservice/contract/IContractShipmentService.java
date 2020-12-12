package com.nicico.sales.iservice.contract;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.contract.ContractShipmentDTO;

import java.util.List;

public interface IContractShipmentService {

    ContractShipmentDTO.Info get(Long id);

    List<ContractShipmentDTO.Info> list();

//    List<ContractShipmentAuditDTO.Info> listAudit();

    ContractShipmentDTO.Info create(ContractShipmentDTO.Create request);

    ContractShipmentDTO.Info update(Long id, ContractShipmentDTO.Update request);

    void delete(Long id);

    void deleteAll(ContractShipmentDTO.Delete request);

    TotalResponse<ContractShipmentDTO.Info> search(NICICOCriteria criteria);

//    TotalResponse<ContractShipmentAuditDTO.Info> searchAudit(NICICOCriteria criteria);
}