package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.sales.dto.PersonDTO;

import java.util.List;

public interface IPersonService {

    PersonDTO.Info get(Long id);

    List<PersonDTO.Info> list();

    PersonDTO.Info create(PersonDTO.Create request);

    PersonDTO.Info update(Long id, PersonDTO.Update request);

    void delete(Long id);

    void deleteAll(PersonDTO.Delete request);

    TotalResponse<PersonDTO.Info> search(NICICOCriteria criteria);
}
