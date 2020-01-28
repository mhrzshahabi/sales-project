package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.SalesException;
import com.nicico.sales.dto.PersonDTO;
import com.nicico.sales.iservice.IPersonService;
import com.nicico.sales.model.entities.base.Person;
import com.nicico.sales.repository.PersonDAO;
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
public class PersonService implements IPersonService {

    private final PersonDAO personDAO;
    private final ModelMapper modelMapper;

    @Transactional(readOnly = true)
    @PreAuthorize("hasAuthority('R_PERSON')")
    public PersonDTO.Info get(Long id) {
        final Optional<Person> slById = personDAO.findById(id);
        final Person person = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PersonNotFound));

        return modelMapper.map(person, PersonDTO.Info.class);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_PERSON')")
    public List<PersonDTO.Info> list() {
        final List<Person> slAll = personDAO.findAll();

        return modelMapper.map(slAll, new TypeToken<List<PersonDTO.Info>>() {
        }.getType());
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('C_PERSON')")
    public PersonDTO.Info create(PersonDTO.Create request) {
        final Person person = modelMapper.map(request, Person.class);

        return save(person);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('U_PERSON')")
    public PersonDTO.Info update(Long id, PersonDTO.Update request) {
        final Optional<Person> slById = personDAO.findById(id);
        final Person person = slById.orElseThrow(() -> new SalesException(SalesException.ErrorType.PersonNotFound));

        Person updating = new Person();
        modelMapper.map(person, updating);
        modelMapper.map(request, updating);

        return save(updating);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_PERSON')")
    public void delete(Long id) {
        personDAO.deleteById(id);
    }

    @Transactional
    @Override
    @PreAuthorize("hasAuthority('D_PERSON')")
    public void delete(PersonDTO.Delete request) {
        final List<Person> persons = personDAO.findAllById(request.getIds());

        personDAO.deleteAll(persons);
    }

    @Transactional(readOnly = true)
    @Override
    @PreAuthorize("hasAuthority('R_PERSON')")
    public TotalResponse<PersonDTO.Info> search(NICICOCriteria criteria) {
        return SearchUtil.search(personDAO, criteria, person -> modelMapper.map(person, PersonDTO.Info.class));
    }

    private PersonDTO.Info save(Person person) {
        final Person saved = personDAO.saveAndFlush(person);
        return modelMapper.map(saved, PersonDTO.Info.class);
    }
}
