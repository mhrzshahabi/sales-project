package com.nicico.sales.exception;

import com.nicico.sales.enumeration.ErrorType;
import lombok.Getter;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.Locale;

@Getter
@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
public class InvalidDataException extends BaseException {

    public InvalidDataException() {

        this(null, null);
    }

    public InvalidDataException(String message) {

        this(null, message);
    }

    public InvalidDataException(Exception innerException) {

        this(innerException, null);
    }

    public InvalidDataException(Exception innerException, String message) {

        super(innerException);

        Locale locale = LocaleContextHolder.getLocale();
        if (StringUtils.isEmpty(message))
            message = messageSource.getMessage("exception.invalid-data", null, locale);

        this.response = new ErrorResponse(ErrorType.InvalidData, null, message);
    }
}
