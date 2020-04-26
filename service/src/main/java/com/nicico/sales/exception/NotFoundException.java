package com.nicico.sales.exception;

import com.nicico.sales.enumeration.ErrorType;
import com.nicico.sales.utility.MessageKeyUtil;
import lombok.Getter;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.Locale;

@Getter
@ResponseStatus(HttpStatus.NOT_FOUND)
public class NotFoundException extends BaseException {

    public NotFoundException() {

        this(null, null);
    }

    public NotFoundException(String message) {

        this.response = new ErrorResponse(ErrorType.NotFound, null, message);
    }

    public NotFoundException(Class<?> entityClass) {

        this(null, entityClass);
    }

    public NotFoundException(Exception innerException) {

        this(innerException, null);
    }

    public NotFoundException(Exception innerException, Class<?> entityClass) {

        super(innerException);

        String message;
        Locale locale = LocaleContextHolder.getLocale();
        if (entityClass == null)
            message = messageSource.getMessage("exception.not-found", null, locale);
        else {

            String code = "entity." + MessageKeyUtil.makeMessageKey(entityClass.getSimpleName());
            message = messageSource.getMessage(code, null, locale);
            message = messageSource.getMessage("exception.entity.not-found", new Object[]{message}, locale);
        }

        this.response = new ErrorResponse(ErrorType.NotFound, null, message);
    }
}