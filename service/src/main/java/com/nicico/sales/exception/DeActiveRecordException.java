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
public class DeActiveRecordException extends BaseException {

    public DeActiveRecordException() {

        this(null, null);
    }

    public DeActiveRecordException(String message) {

        this(null, message);
    }

    public DeActiveRecordException(Exception innerException) {

        this(innerException, null);
    }

    public DeActiveRecordException(Exception innerException, String message) {

        super(innerException);

        Locale locale = LocaleContextHolder.getLocale();
        if (StringUtils.isEmpty(message))
            message = messageSource.getMessage("exception.inactive.not-editable", null, locale);

        this.response = new ErrorResponse(ErrorType.DeActiveRecord, null, message);
    }
}
