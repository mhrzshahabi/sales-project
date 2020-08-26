package com.nicico.sales.service;

import com.nicico.sales.dto.PersonDTO;
import com.nicico.sales.iservice.IPersonService;
import com.nicico.sales.model.entities.base.Person;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class PersonService extends GenericService<Person, Long, PersonDTO.Create, PersonDTO.Info, PersonDTO.Update, PersonDTO.Delete> implements IPersonService {
}
