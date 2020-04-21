package com.nicico.sales.service;

import com.nicico.copper.common.domain.criteria.NICICOCriteria;
import com.nicico.copper.common.domain.criteria.SearchUtil;
import com.nicico.copper.common.dto.grid.TotalResponse;
import com.nicico.copper.common.dto.search.SearchDTO;
import com.nicico.sales.annotation.Action;
import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import com.nicico.sales.iservice.IGenericService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Transactional
@RequiredArgsConstructor
public abstract class GenericService<T, ID extends Serializable, C, R, U, D> implements IGenericService<T, ID, C, R, U, D> {

    private Class<T> tType;
    private Class<R> rType;
    private Class<U> uType;
    private Class<D> dType;

    protected ActionType actionType;

    @Autowired
    protected ModelMapper modelMapper;
    @Autowired
    protected EntityManager entityManager;
    @Autowired
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    protected JpaRepository<T, ID> repository;
    @Autowired
    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    protected JpaSpecificationExecutor<T> repositorySpecificationExecutor;

    {
        ParameterizedType superClass = (ParameterizedType) getClass().getGenericSuperclass();
        //noinspection unchecked
        tType = (Class<T>) superClass.getActualTypeArguments()[0];
        //noinspection unchecked
        rType = (Class<R>) superClass.getActualTypeArguments()[3];
        //noinspection unchecked
        uType = (Class<U>) superClass.getActualTypeArguments()[4];
        //noinspection unchecked
        dType = (Class<D>) superClass.getActualTypeArguments()[5];
    }

    @Override
    @Action(value = ActionType.Get)
    @Transactional(readOnly = true)
    public R get(ID id) {

        final Optional<T> entityById = repository.findById(id);
        final T entity = entityById.orElseThrow(() -> new SalesException2(ErrorType.NotFound));

        R result = modelMapper.map(entity, rType);

        validation(entity, result);
        return result;
    }

    @Override
    @Action(value = ActionType.List)
    @Transactional(readOnly = true)
    public List<R> getAll(List<ID> ids) {

        final List<T> entities = repository.findAllById(ids);

        List<R> result = entities.stream().map(q -> {

            R eResult = modelMapper.map(q, rType);
            validation(q, eResult);
            return eResult;
        }).collect(Collectors.toList());

        validationAll(entities, result);
        return result;
    }

    @Override
    @Action(value = ActionType.List)
    @Transactional(readOnly = true)
    public List<R> list() {

        final List<T> entities = repository.findAll();

        List<R> result = entities.stream().map(q -> {

            R eResult = modelMapper.map(q, rType);
            validation(q, eResult);
            return eResult;
        }).collect(Collectors.toList());

        validationAll(entities, result);
        return result;
    }

    @Override
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public TotalResponse<R> search(NICICOCriteria request) {

        List<T> entities = new ArrayList<>();
        TotalResponse<R> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            R eResult = modelMapper.map(entity, rType);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @Action(value = ActionType.Search)
    @Transactional(readOnly = true)
    public SearchDTO.SearchRs<R> search(SearchDTO.SearchRq request) {

        List<T> entities = new ArrayList<>();
        SearchDTO.SearchRs<R> result = SearchUtil.search(repositorySpecificationExecutor, request, entity -> {

            R eResult = modelMapper.map(entity, rType);
            validation(entity, eResult);
            entities.add(entity);
            return eResult;
        });

        validationAll(entities, result);
        return result;
    }

    @Override
    @Action(value = ActionType.Create)
    @Transactional
    public R create(C request) {

        final T entity = modelMapper.map(request, tType);
        validation(entity, request);

        return save(entity);
    }

    @Override
    @Action(value = ActionType.CreateAll)
    @Transactional
    public List<R> createAll(List<C> requests) {

        final List<T> entities = requests.stream().map(q -> {

            T entity = modelMapper.map(q, tType);
            validation(entity, q);
            return entity;
        }).collect(Collectors.toList());

        validationAll(entities, requests);
        return saveAll(entities);
    }

    @Override
    @Action(value = ActionType.Update)
    @Transactional
    @SuppressWarnings("unchecked")
    public R update(U request) {

        Method idGetterMethod = getMethod(uType, new String[]{"getId", "getCode"});
        try {

            ID id = (ID) idGetterMethod.invoke(request);
            return update(id, request);

        } catch (IllegalAccessException | InvocationTargetException e) {

            e.printStackTrace();
            log.error("Exception", e);
        }

        return null;
    }

    @Override
    @Action(value = ActionType.Update)
    @Transactional
    public R update(ID id, U request) {

        final Optional<T> entityById = repository.findById(id);
        final T entity = entityById.orElseThrow(() -> new SalesException2(ErrorType.NotFound));

        try {

            T updating = tType.getDeclaredConstructor().newInstance();

            modelMapper.map(entity, updating);
            modelMapper.map(request, updating);

            validation(updating, request);
            return save(updating);

        } catch (NoSuchMethodException | InvocationTargetException | InstantiationException | IllegalAccessException e) {

            e.printStackTrace();
            log.error("Exception", e);
        }

        return null;
    }

    @Override
    @Action(value = ActionType.UpdateAll)
    @Transactional
    @SuppressWarnings("unchecked")
    public List<R> updateAll(List<U> requests) {

        Method idGetterMethod = getMethod(uType, new String[]{"getId", "getCode"});
        Set<ID> ids = requests.stream().map(q -> {

            try {

                return (ID) idGetterMethod.invoke(q);

            } catch (IllegalAccessException | InvocationTargetException e) {

                e.printStackTrace();
                log.error("Exception", e);
            }

            return null;

        }).collect(Collectors.toSet());
        ids.remove(null);

        return updateAll(new ArrayList<>(ids), requests);
    }

    @Override
    @Action(value = ActionType.UpdateAll)
    @Transactional
    public List<R> updateAll(List<ID> ids, List<U> requests) {

        try {

            List<T> entities = new ArrayList<>();
            for (int i = 0; i < ids.size(); i++) {

                ID id = ids.get(i);
                U request = requests.get(i);
                final Optional<T> entityById = repository.findById(id);
                final T entity = entityById.orElseThrow(() -> new SalesException2(ErrorType.NotFound));

                T updating = tType.getDeclaredConstructor().newInstance();
                modelMapper.map(entity, updating);
                modelMapper.map(request, updating);

                validation(updating, request);
                entities.add(updating);
            }

            validationAll(entities, requests);
            return saveAll(entities);

        } catch (NoSuchMethodException | InvocationTargetException | InstantiationException | IllegalAccessException e) {

            e.printStackTrace();
            log.error("Exception", e);
        }

        return new ArrayList<>();
    }

    @Override
    @Action(value = ActionType.Delete)
    @Transactional
    public void delete(ID id) {

        final Optional<T> entityById = repository.findById(id);
        final T entity = entityById.orElseThrow(() -> new SalesException2(ErrorType.NotFound));

        validation(entity, id);

        repository.deleteById(id);
    }

    @Override
    @Action(value = ActionType.DeleteAll)
    @Transactional
    @SuppressWarnings("unchecked")
    public void deleteAll(D request) {

        Method idsGetterMethod = getMethod(dType, new String[]{"getIds", "getCodes"});
        try {

            final List<T> entities = repository.findAllById((Iterable<ID>) idsGetterMethod.invoke(request));

            entities.forEach(q -> validation(q, request));

            validationAll(entities, request);
            repository.deleteAll(entities);

        } catch (IllegalAccessException | InvocationTargetException e) {

            e.printStackTrace();
            log.error("Exception", e);
        }
    }

    @Override
    public R save(T entity) {

        return modelMapper.map(repository.saveAndFlush(entity), rType);
    }

    @Override
    public List<R> saveAll(List<T> entities) {

        return repository.saveAll(entities).stream().map(q -> modelMapper.map(q, rType)).collect(Collectors.toList());
    }

    @Override
    public Boolean validation(T entity, Object... request) {

        return null;
    }

    @Override
    public Boolean validationAll(List<T> entity, Object... request) {

        return null;
    }

    private <K> @NotNull Method getMethod(Class<K> clazz, String[] names) {

        for (String name : names) {

            try {

                return clazz.getDeclaredMethod(name);

            } catch (NoSuchMethodException e) {

                e.printStackTrace();
                log.error("Exception", e);
            }
        }

        throw new SalesException2(ErrorType.Unknown, "id", "شناسه موجودیت یافت نشد.");
    }
}