package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.model.entities.base.ContactAccount;

import java.util.List;

public interface IContactService {

    ContactDTO.Info get(Long id);

    List<ContactDTO.Info> list();

    ContactDTO.Info create(ContactDTO.Create request);

    ContactDTO.Info update(Long id, ContactDTO.Update request);

    void delete(Long id);

    void deleteAll(ContactDTO.Delete request);

    TotalResponse<ContactDTO.Info> search(NICICOCriteria criteria);

    void updateContactDefaultAccount(ContactAccount contactAccount);

    void removeContactDefaultAccount(ContactAccount contactAccount);
}
