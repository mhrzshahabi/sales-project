package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContactDTO;

import java.util.List;

public interface IContactService {

    ContactDTO.Info get(Long id);

    List<ContactDTO.Info> list();

    ContactDTO.Info create(ContactDTO.Create request);

    ContactDTO.Info update(Long id, ContactDTO.Update request);

    void delete(Long id);

    void delete(ContactDTO.Delete request);

    TotalResponse<ContactDTO.Info> search(NICICOCriteria criteria);
}
