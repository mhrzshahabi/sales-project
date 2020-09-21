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
}
