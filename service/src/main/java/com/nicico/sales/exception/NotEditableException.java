package com.nicico.sales.exception;

import com.nicico.sales.enumeration.ErrorType;
import lombok.Getter;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.Locale;

@Getter
@ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
public class NotEditableException extends BaseException {

    public NotEditableException() {

        this(null, null);
    }

    public NotEditableException(String message) {

        this(null, message);
    }

    public NotEditableException(Exception innerException) {

        this(innerException, null);
    }

    public NotEditableException(Exception innerException, String message) {

        super(innerException);

        Locale locale = LocaleContextHolder.getLocale();
        if (StringUtils.isEmpty(message))
            message = messageSource.getMessage("exception.not-editable", null, locale);

        this.response = new ErrorResponse(ErrorType.NotEditable, null, message);
    }
}
