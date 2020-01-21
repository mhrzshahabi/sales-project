package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.ContactAccountDTO;
import com.nicico.sales.iservice.IContactAccountService;
import com.nicico.sales.model.entities.base.ContactAccount;
import com.nicico.sales.repository.ContactAccountDAO;
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
public class ContactAccountService implements IContactAccountService {

    private final ContactAccountDAO contactAccountDAO;
    private final ContactService contactService;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_CONTACT_ACCOUNT')")
    public ContactAccountDTO.Info get(Long id) {
        final Optional<ContactAccount> slById = contactAccountDAO.findById(id);
        final ContactAccount contactAccount = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.ContactAccountNotFound));

        return modelMapper.map(contactAccount, ContactAccountDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTACT_ACCOUNT')")
    public List<ContactAccountDTO.Info> list() {
        final List<ContactAccount> slAll = contactAccountDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<ContactAccountDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_CONTACT_ACCOUNT')")
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
    @PreAuthorize("hasAuthority('U_CONTACT_ACCOUNT')")
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
    @PreAuthorize("hasAuthority('D_CONTACT_ACCOUNT')")
    public void delete(Long id) {
        contactAccountDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_CONTACT_ACCOUNT')")
    public void delete(ContactAccountDTO.Delete request) {
        final List<ContactAccount> contactAccounts = contactAccountDAO.findAllById(request.getIds());

        contactAccountDAO.deleteAll(contactAccounts);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTACT_ACCOUNT')")
    public SearchDTO.SearchRs<ContactAccountDTO.Info> search(SearchDTO.SearchRq request) {
        return SearchUtil.search(contactAccountDAO, request, contactAccount -> modelMapper.map(contactAccount, ContactAccountDTO.Info.class));
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_CONTACT_ACCOUNT')")
    public TotalResponse<ContactAccountDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(contactAccountDAO, criteria, contactAccount -> modelMapper.map(contactAccount, ContactAccountDTO.Info.class));
    }

    private ContactAccountDTO.Info save(ContactAccount contactAccount) {
        final ContactAccount saved = contactAccountDAO.saveAndFlush(contactAccount);
        return modelMapper.map(saved, ContactAccountDTO.Info.class);
    }
}
