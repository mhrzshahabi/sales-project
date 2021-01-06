package com.nicico.sales.service.contract;

import com.nicico.sales.dto.contract.ContractShipmentDTO;
import com.nicico.sales.iservice.contract.IContractShipmentService;
import com.nicico.sales.model.entities.contract.ContractShipment;
import com.nicico.sales.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class ContractShipmentService extends GenericService<ContractShipment, Long, ContractShipmentDTO.Create, ContractShipmentDTO.Info, ContractShipmentDTO.Update, ContractShipmentDTO.Delete> implements IContractShipmentService {
}
