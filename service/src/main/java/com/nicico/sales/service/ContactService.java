package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.iservice.IContactService;
import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.ContactAccount;
import com.nicico.sales.repository.ContactDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.security.access.prepost.PreAuthorize;
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
    @Override
    @PreAuthorize("hasAuthority('R_CONTACT')")
    public ContactDTO.Info get(Long id) {
        final Optional<Contact> slById = contactDAO.findById(id);
        final Contact contact = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactNotFound));

        return modelMapper.map(contact, ContactDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTACT')")
    public List<ContactDTO.Info> list() {
        final List<Contact> slAll = contactDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContactDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_CONTACT')")
    public ContactDTO.Info create(ContactDTO.Create request) {
        final Contact contact = modelMapper.map(request, Contact.class);

        return save(contact);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_CONTACT')")
    public ContactDTO.Info update(Long id, ContactDTO.Update request) {
        final Optional<Contact> slById = contactDAO.findById(id);
        final Contact contact = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactNotFound));

        Contact updating = new Contact();
        modelMapper.map(contact, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    public void updateContactDefaultAccount(ContactAccount contactAccount) {
        final Optional<Contact> slById = contactDAO.findById(contactAccount.getContactId());
        final Contact contact = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactNotFound));
        contact.setBankAccount(contactAccount.getBankAccount());
        contact.setBankShaba(contactAccount.getBankShaba());
        contact.setBankSwift(contactAccount.getBankSwift());
        Contact updating = new Contact();
        modelMapper.map(contact, updating);
        save(updating);
    }

    @Transactional
    public void removeContactDefaultAccount(ContactAccount contactAccount) {
        final Optional<Contact> slById = contactDAO.findById(contactAccount.getContactId());
        final Contact contact = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactNotFound));
        contact.setBankAccount(null);
        contact.setBankShaba(null);
        contact.setBankSwift(null);
        Contact updating = new Contact();
        modelMapper.map(contact, updating);
        save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTACT')")
    public void delete(Long id) {
        contactDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTACT')")
    public void delete(ContactDTO.Delete request) {
        final List<Contact> contacts = contactDAO.findAllById(request.getIds());

        contactDAO.deleteAll(contacts);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTACT')")
    public TotalResponse<ContactDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(contactDAO, criteria, contact -> modelMapper.map(contact, ContactDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTACT')")
    public SearchDTO.SearchRs<ContactDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(contactDAO, request, contact -> modelMapper.map(contact, ContactDTO.Info.class));
    }

    private ContactDTO.Info save(Contact contact) {
        final Contact saved = contactDAO.saveAndFlush(contact);
        return modelMapper.map(saved, ContactDTO.Info.class);
    }
}
