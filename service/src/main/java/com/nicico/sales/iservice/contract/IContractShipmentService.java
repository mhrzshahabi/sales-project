package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.ContractShipmentDTO;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractShipment;

public interface IContractShipmentService extends IGenericService<ContractShipment, Long, ContractShipmentDTO.Create, ContractShipmentDTO.Info, ContractShipmentDTO.Update, ContractShipmentDTO.Delete> {
}
