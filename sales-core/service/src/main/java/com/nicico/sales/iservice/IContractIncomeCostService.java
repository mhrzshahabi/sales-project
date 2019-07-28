package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContractIncomeCostDTO;
import net.sf.jasperreports.engine.JRException;

import java.util.ArrayList;
import java.util.List;

public interface IContractIncomeCostService {

	ContractIncomeCostDTO.Info get(Long id);

	List<ContractIncomeCostDTO.Info> list();

	ContractIncomeCostDTO.Info create(ContractIncomeCostDTO.Create request);

	ContractIncomeCostDTO.Info update(Long id, ContractIncomeCostDTO.Update request);

	void delete(Long id);

	void delete(ContractIncomeCostDTO.Delete request);

	SearchDTO.SearchRs<ContractIncomeCostDTO.Info> search(SearchDTO.SearchRq request);

	void pdfFx(List<ContractIncomeCostDTO.Info> myList, ArrayList<String> columns) throws JRException;
}
