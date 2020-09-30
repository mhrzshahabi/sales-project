package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.ContactDTO;
import com.nicico.sales.iservice.IContactService;
import com.nicico.sales.model.entities.base.Contact;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@RequiredArgsConstructor
@Service
public class ContactService extends GenericService<Contact, Long, ContactDTO.Create, ContactDTO.Info, ContactDTO.Update, ContactDTO.Delete> implements IContactService {

    @Override
    public TotalResponse<ContactDTO.Info> search(NICICOCriteria request) {
        LinkedList<String> criteriaList = (LinkedList<String>) request.getCriteria();
        LinkedList newCriteria = new LinkedList();
        boolean hasDefault = false;
        if (criteriaList != null && !criteriaList.isEmpty()) {
            for (String criterion : criteriaList) {
                if (criterion.contains(":\"defaultAccount.")) {
                    hasDefault = true;
                    newCriteria.add(criterion.replace("defaultAccount", "contactAccounts"));
                } else
                    newCriteria.add(criterion);
            }
            if (hasDefault)
                newCriteria.add("{\"fieldName\":\"contactAccounts.isDefault\",\"operator\":\"equals\",\"value\":true}");
            request.setCriteria(newCriteria);
        }
        return super.search(request);
    }
}
