package com.nicico.sales.utility;

import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.exception.SalesException2;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotNull;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class UpdateUtil {

    private final ModelMapper modelMapper;

    public <T, C, R, U, D> void fill(
            Class<T> savedType, List<T> saved,
            Class<R> requestType, List<R> request,
            Class<C> _4InsertType, List<C> _4Insert,
            Class<U> _4UpdateType, List<U> _4Update,
            D _4Delete) throws InvocationTargetException, IllegalAccessException, NoSuchFieldException {

        Class<D> _4DeleteType = (Class<D>) _4Delete.getClass();

        for (R r : request) {

            if (getIdMethod(r.getClass(), "getId").invoke(r) == null)
                _4Insert.add(modelMapper.map(r, _4InsertType));
            else
                _4Update.add(modelMapper.map(r, _4UpdateType));
        }

        @NotNull Method savedIdMethod = getIdMethod(savedType, "getId");
        @NotNull Method requestIdMethod = getIdMethod(requestType, "getId");
        Field ids = _4DeleteType.getDeclaredField("ids");
        ids.setAccessible(true);
        ids.set(_4Delete, saved.stream().
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
                        return requestIdMethod.invoke(p).equals(q);
                    } catch (IllegalAccessException | InvocationTargetException e) {

                        log.error("Exception", e);
                        e.printStackTrace();
                        throw new SalesException2(ErrorType.Unknown, "id", "شناسه موجودیت یافت نشد.");
                    }
                })).
                collect(Collectors.toList()));
    }

    private <K> @NotNull Method getIdMethod(Class<K> clazz, String name) {

        try {

            return clazz.getDeclaredMethod(name);

        } catch (NoSuchMethodException e) {

            e.printStackTrace();
            log.error("Exception", e);
        }

        throw new SalesException2(ErrorType.Unknown, "id", "شناسه موجودیت یافت نشد.");
    }
}
