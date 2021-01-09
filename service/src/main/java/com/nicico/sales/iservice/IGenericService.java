package com.nicico.sales.iservice;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;

import java.io.Serializable;
import java.util.List;

public interface IGenericService<T, ID extends Serializable, C, R, U, D> {

    R get(ID id);

    List<R> getAll(List<ID> ids);

    List<R> list();

    TotalResponse<R> search(NICICOCriteria request);

    SearchDTO.SearchRs<R> search(SearchDTO.SearchRq request);

    R create(C request);

    List<R> createAll(List<C> requests);

    R update(U request);

    R update(ID id, U request);

    List<R> updateAll(List<U> requests);

    List<R> updateAll(List<ID> ids, List<U> requests);

    void delete(ID id);

    void deleteAll(D request);

    R finalize(ID id);

    R disapprove(ID id);

    R activate(ID id);

    R deactivate(ID id);

    R save(T entity);

    List<R> saveAll(List<T> entities);

    R saveWithoutFlush(T entity);

    void flush();

    Boolean validation(T entity, Object... request);

    Boolean validationAll(List<T> entities, Object... request);
}
