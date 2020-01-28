package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractShipmentDTO;

import java.util.List;

public interface IContractShipmentService {

    ContractShipmentDTO.Info get(Long id);

    List<ContractShipmentDTO.Info> list();

    ContractShipmentDTO.Info create(ContractShipmentDTO.Create request);

    ContractShipmentDTO.Info update(Long id, ContractShipmentDTO.Update request);

    void delete(Long id);

    void delete(ContractShipmentDTO.Delete request);

    TotalResponse<ContractShipmentDTO.Info> search(NICICOCriteria criteria);
}
