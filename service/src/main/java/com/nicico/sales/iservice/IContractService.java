package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContractDTO;

import java.util.List;

public interface IContractService {

    ContractDTO.Info get(Long id);

    List<ContractDTO.Info> list();

    void writeToWord(String request) throws Exception;

    List<String> readFromWord(String contractNo, Long contractId, int draftId);

    ContractDTO.Info create(ContractDTO.Create request);

    ContractDTO.Info update(Long id, ContractDTO.Update request);

    void delete(Long id);

    String printContract(Long id);

    String printContract(Long id, Long idDraft);

    void delete(ContractDTO.Delete request);

    TotalResponse<ContractDTO.Info> search(NICICOCriteria criteria);

    TotalResponse<ContractDTO.InfoForReport> report(NICICOCriteria nicicoCriteria);
}
