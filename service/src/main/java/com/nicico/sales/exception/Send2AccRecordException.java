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
public class Send2AccRecordException extends BaseException {

    public Send2AccRecordException() {

        this(null, null);
    }

    public Send2AccRecordException(String message) {

        this(null, message);
    }

    public Send2AccRecordException(Exception innerException) {

        this(innerException, null);
    }

    public Send2AccRecordException(Exception innerException, String message) {

        super(innerException);

        Locale locale = LocaleContextHolder.getLocale();
        if (StringUtils.isEmpty(message))
            message = messageSource.getMessage("exception.send2acc.not-editable", null, locale);

        this.response = new ErrorResponse(ErrorType.Send2AccRecord, null, message);
    }
}
