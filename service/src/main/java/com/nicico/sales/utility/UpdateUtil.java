package com.nicico.sales.utility;

import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotNull;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class UpdateUtil {

    private final ModelMapper modelMapper;

    public <T, C, R, U, D> void fill(List<T> saved, List<R> request, List<C> _4Insert, List<U> _4Update, D _4Delete) throws InvocationTargetException, IllegalAccessException {

        Class<D> _4DeleteType = (Class<D>) _4Delete.getClass();
        Class<T> savedType = (Class<T>) ((ParameterizedType) saved.getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        Class<R> requestType = (Class<R>) ((ParameterizedType) request.getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        Class<C> _4InsertType = (Class<C>) ((ParameterizedType) _4Insert.getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        Class<U> _4UpdateType = (Class<U>) ((ParameterizedType) _4Update.getClass().getGenericSuperclass()).getActualTypeArguments()[0];

        for (R r : request) {

            if (getIdMethod(r.getClass(), new String[]{"getId", "getCode"}).invoke(r) == null)
                _4Insert.add(modelMapper.map(r, _4InsertType));
            else
                _4Update.add(modelMapper.map(r, _4UpdateType));
        }

        @NotNull Method savedIdMethod = getIdMethod(savedType, new String[]{"getId", "getCode"});
        @NotNull Method requestIdMethod = getIdMethod(requestType, new String[]{"getId", "getCode"});
        getIdMethod(_4DeleteType, new String[]{"setIds", "setCodes"}).invoke(_4Delete, saved.stream().
                map(q -> {
                    try {
                        return (Long) savedIdMethod.invoke(q);
                    } catch (IllegalAccessException | InvocationTargetException e) {

                        log.error("Exception", e);
                        e.printStackTrace();
                        throw new SalesException2(ErrorType.Unknown, "id", "شناسه موجودیت یافت نشد.");
                    }
                }).
                filter(q -> request.stream().noneMatch(p -> {
                    try {
                        return requestIdMethod.invoke(p) == q;
                    } catch (IllegalAccessException | InvocationTargetException e) {

                        log.error("Exception", e);
                        e.printStackTrace();
                        throw new SalesException2(ErrorType.Unknown, "id", "شناسه موجودیت یافت نشد.");
                    }
                })).
                collect(Collectors.toList()));
    }

    private <K> @NotNull Method getIdMethod(Class<K> clazz, String[] names) {

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