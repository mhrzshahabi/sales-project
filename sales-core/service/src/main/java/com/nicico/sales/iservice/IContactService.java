package com.nicico.sales.iservice;

import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.dto.ContactDTO;

import java.util.List;

public interface IContactService {

	ContactDTO.Info get(Long id);

	List<ContactDTO.Info> list();

	ContactDTO.Info create(ContactDTO.Create request);

	ContactDTO.Info update(Long id, ContactDTO.Update request);

	void delete(Long id);

	void delete(ContactDTO.Delete request);

	SearchDTO.SearchRs<ContactDTO.Info> search(SearchDTO.SearchRq request);
}
