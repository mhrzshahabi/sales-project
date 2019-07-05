package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.iservice.IContactService;
import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.repository.ContactDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContactService implements IContactService {

	private final ContactDAO contactDAO;
	private final ModelMapper modelMapper;

	@Transactional(readOnly = true)
	public ContactDTO.Info get(Long id) {
		final Optional<Contact> slById = contactDAO.findById(id);
		final Contact contact = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactNotFound));

		return modelMapper.map(contact, ContactDTO.Info.class);
	}

	@Transactional(readOnly = true)
	@Override
	public List<ContactDTO.Info> list() {
		final List<Contact> slAll = contactDAO.findAll();

		return modelMapper.map(slAll, new TypeToken<List<ContactDTO.Info>>() {
		}.getType());
	}

	@Transactional
	@Override
	public ContactDTO.Info create(ContactDTO.Create request) {
		final Contact contact = modelMapper.map(request, Contact.class);

		return save(contact);
	}

	@Transactional
	@Override
	public ContactDTO.Info update(Long id, ContactDTO.Update request) {
		final Optional<Contact> slById = contactDAO.findById(id);
		final Contact contact = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactNotFound));

		Contact updating = new Contact();
		modelMapper.map(contact, updating);
		modelMapper.map(request, updating);

		return save(updating);
	}

	@Transactional
	@Override
	public void delete(Long id) {
		contactDAO.deleteById(id);
	}

	@Transactional
	@Override
	public void delete(ContactDTO.Delete request) {
		final List<Contact> contacts = contactDAO.findAllById(request.getIds());

		contactDAO.deleteAll(contacts);
	}

	@Transactional(readOnly = true)
	@Override
	public SearchDTO.SearchRs<ContactDTO.Info> search(SearchDTO.SearchRq request) {
		return SearchUtil.search(contactDAO, request, contact -> modelMapper.map(contact, ContactDTO.Info.class));
	}

	// ------------------------------

	private ContactDTO.Info save(Contact contact) {
		final Contact saved = contactDAO.saveAndFlush(contact);
		return modelMapper.map(saved, ContactDTO.Info.class);
	}
}
