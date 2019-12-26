package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractDTO;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;

public interface IContractService {

	ContractDTO.Info get(Long id);

	List<ContractDTO.Info> list();

	void writeToWord(String request) throws IOException, InvalidFormatException, ParseException;

	List<String> readFromWord(String contractNo);

	ContractDTO.Info create(ContractDTO.Create request);

	ContractDTO.Info update(Long id, ContractDTO.Update request);

	void delete(Long id);

	String printContract(Long id);

	void delete(ContractDTO.Delete request);

	TotalResponse<ContractDTO.Info> search(NICICOCriteria criteria);

	SearchDTO.SearchRs<ContractDTO.Info> search(SearchDTO.SearchRq request);
}
