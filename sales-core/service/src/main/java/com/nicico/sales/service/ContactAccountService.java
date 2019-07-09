package com.nicico.sales.service;

import com.nicico.copper.core.domain.criteria.SearchUtil;
import com.nicico.copper.core.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContactAccountDTO;
import com.nicico.sales.iservice.IContactAccountService;
import com.nicico.sales.model.entities.base.ContactAccount;
import com.nicico.sales.repository.ContactAccountDAO;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ContactAccountService implements IContactAccountService {

    private final ContactAccountDAO contactAccountDAO;
    private final ContactService contactService;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    public ContactAccountDTO.Info get(Long id) {
        final Optional<ContactAccount> slById = contactAccountDAO.findById(id);
        final ContactAccount contactAccount = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactAccountNotFound));

        return modelMapper.map(contactAccount, ContactAccountDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    public List<ContactAccountDTO.Info> list() {
        final List<ContactAccount> slAll = contactAccountDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContactAccountDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    public ContactAccountDTO.Info create(ContactAccountDTO.Create request) {
        final ContactAccount contactAccount = modelMapper.map(request, ContactAccount.class);
        if (contactAccount.getIsDefault()) {
            updateDefaultAccounts(contactAccount);
        }
        return save(contactAccount);
    }

    private void updateDefaultAccounts(ContactAccount contactAccount) {
        //remove all contact account from default state
        List<ContactAccount> byContactId = contactAccountDAO.findByContactId(contactAccount.getContactId());
        for (ContactAccount ca : byContactId) {
            ca.setIsDefault(false);
            contactAccountDAO.save(ca);
        }
        //update account info of contact
        contactService.updateContactDefaultAccount(contactAccount);
    }

    @Transactional
    @Override
    public ContactAccountDTO.Info update(Long id, ContactAccountDTO.Update request) {
        final Optional<ContactAccount> slById = contactAccountDAO.findById(id);
        final ContactAccount contactAccount = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactAccountNotFound));

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
        return save(updating);
    }

    @Transactional
    @Override
    public void delete(Long id) {
        contactAccountDAO.deleteById(id);
    }

    @Transactional
    @Override
    public void delete(ContactAccountDTO.Delete request) {
        final List<ContactAccount> contactAccounts = contactAccountDAO.findAllById(request.getIds());

        contactAccountDAO.deleteAll(contactAccounts);
    }

    public SearchDTO.SearchRs<ContactAccountDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(contactAccountDAO, request, contactAccount -> modelMapper.map(contactAccount, ContactAccountDTO.Info.class));
    }

    // ------------------------------

    private ContactAccountDTO.Info save(ContactAccount contactAccount) {
        final ContactAccount saved = contactAccountDAO.saveAndFlush(contactAccount);
        return modelMapper.map(saved, ContactAccountDTO.Info.class);
    }
}
