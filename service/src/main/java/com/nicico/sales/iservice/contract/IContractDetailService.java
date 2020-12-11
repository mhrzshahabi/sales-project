package com.nicico.sales.iservice.contract;

import com.nicico.sales.dto.contract.ContractDetailDTO;
import com.nicico.sales.enumeration.EContractDetailTypeCode;
import com.nicico.sales.iservice.IGenericService;
import com.nicico.sales.model.entities.contract.ContractDetail;

public interface IContractDetailService extends IGenericService<ContractDetail, Long, ContractDetailDTO.Create, ContractDetailDTO.Info, ContractDetailDTO.Update, ContractDetailDTO.Delete> {

    ContractDetailDTO.Info getContractDetailByContractDetailTypeCode(Long contractId, Long materialId, EContractDetailTypeCode typeCode);
}
