package com.nicico.sales.service;

import com.nicico.sales.annotation.Action;
import com.nicico.sales.dto.ContactAccountDTO;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.exception.NotFoundException;
import com.nicico.sales.iservice.IContactAccountService;
import com.nicico.sales.model.entities.base.Contact;
import com.nicico.sales.model.entities.base.ContactAccount;
import com.nicico.sales.repository.ContactAccountDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContactAccountService extends GenericService<ContactAccount, Long, ContactAccountDTO.Create, ContactAccountDTO.Info, ContactAccountDTO.Update, ContactAccountDTO.Delete> implements IContactAccountService {

    private final ContactService contactService;

    @Override
    @Action(value = ActionType.Create)
    @Transactional
    public ContactAccountDTO.Info create(ContactAccountDTO.Create request) {
        final ContactAccount contactAccount = modelMapper.map(request, ContactAccount.class);
        if (contactAccount.getIsDefault()) {
            updateDefaultAccounts(contactAccount);
        }
        return save(contactAccount);
    }

    private void updateDefaultAccounts(ContactAccount contactAccount) {
        //remove all contact account from default state
        List<ContactAccount> byContactId = ((ContactAccountDAO)repository).findByContactId(contactAccount.getContactId());
        for (ContactAccount ca : byContactId) {
            ca.setIsDefault(false);
            repository.save(ca);
        }
        //update account info of contact
        contactService.updateContactDefaultAccount(contactAccount);
    }

    @Override
    @Action(value = ActionType.Update)
    @Transactional
    public ContactAccountDTO.Info update(Long id, ContactAccountDTO.Update request) {
        final Optional<ContactAccount> slById = ((ContactAccountDAO)repository).findById(id);
        final ContactAccount contactAccount = slById.orElseThrow(() -> new NotFoundException(ContactAccount.class));

        ContactAccount updating = new ContactAccount();
        modelMapper.map(contactAccount, updating); //map audits
        modelMapper.map(request, updating); //map new values

        //update account info of contact
        if (contactAccount.getIsDefault() != request.getIsDefault()) {
            if (request.getIsDefault()) {
                updateDefaultAccounts(updating);
            } else {
                contactService.removeContactDefaultAccount(updating);
            }
        }
        if (request.getIsDefault()) { // @TODO this was an extremely tofmalization , change (contact) Data Model
            Contact contact = new Contact();
            modelMapper.map(contactService.get(contactAccount.getContactId()), contact);
            boolean contactDefaultAccountChanged = !request.getBankAccount().equals(contact.getBankAccount()) ||
                    !request.getBankShaba().equals(contact.getBankShaba()) ||
                    !request.getBankSwift().equals(contact.getBankSwift());

            if (contactDefaultAccountChanged) {
                contact.setBankAccount(request.getBankAccount());
                contact.setBankShaba(request.getBankShaba());
                contact.setBankSwift(request.getBankSwift());
                contactService.save(contact);
            }
        }
        return save(updating);
    }


}
