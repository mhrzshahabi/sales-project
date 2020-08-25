package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IContactService;
import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.ContactAccount;
import com.nicico.sales.model.entities.base.Contract;
import com.nicico.sales.repository.ContactDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContactService extends GenericService<Contact, Long, ContactDTO.Create, ContactDTO.Info, ContactDTO.Update, ContactDTO.Delete> implements IContactService {


    @Action(value = ActionType.Update)
    @Transactional
    @Override
    public void updateContactDefaultAccount(ContactAccount contactAccount) {
        final Optional<Contact> slById = repository.findById(contactAccount.getContactId());
        final Contact contact = slById.orElseThrow(() -> new NotFoundException(Contract.class));
        contact.setBankAccount(contactAccount.getBankAccount());
        contact.setBankShaba(contactAccount.getBankShaba());
        contact.setBankSwift(contactAccount.getBankSwift());
        Contact updating = new Contact();
        modelMapper.map(contact, updating);
        save(updating);
    }

    @Action(value = ActionType.Update)
    @Transactional
    @Override
    public void removeContactDefaultAccount(ContactAccount contactAccount) {
        final Optional<Contact> slById = repository.findById(contactAccount.getContactId());
        final Contact contact = slById.orElseThrow(() -> new NotFoundException(Contract.class));
        contact.setBankAccount(null);
        contact.setBankShaba(null);
        contact.setBankSwift(null);
        Contact updating = new Contact();
        modelMapper.map(contact, updating);
        save(updating);
    }


}
