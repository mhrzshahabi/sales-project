package com.nicico.sales.iservice;

import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.dto.ContactAccountDTO;

import java.util.List;

public interface IContactAccountService {

	ContactAccountDTO.Info get(Long id);

	List<ContactAccountDTO.Info> list();

	ContactAccountDTO.Info create(ContactAccountDTO.Create request);

	ContactAccountDTO.Info update(Long id, ContactAccountDTO.Update request);

	void delete(Long id);

	void delete(ContactAccountDTO.Delete request);

	SearchDTO.SearchRs<ContactAccountDTO.Info> search(SearchDTO.SearchRq request);
}
