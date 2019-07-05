package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.BankDTO;

import java.util.List;

public interface IBankService {

	BankDTO.Info get(Long id);

	List<BankDTO.Info> list();

	BankDTO.Info create(BankDTO.Create request);

	BankDTO.Info update(Long id, BankDTO.Update request);

	void delete(Long id);

	void delete(BankDTO.Delete request);

	SearchDTO.SearchRs<BankDTO.Info> search(SearchDTO.SearchRq request);
}
