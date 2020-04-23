package com.nicico.sales.exception;

import com.nicico.sales.enumeration.ErrorType;
import lombok.Getter;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.Locale;

@Getter
@ResponseStatus(HttpStatus.UNAUTHORIZED)
public class UnAuthorizedException extends BaseException {

    public UnAuthorizedException() {

        this(null, null);
    }

    public UnAuthorizedException(String accessKey) {

        this(null, accessKey);
    }

    public UnAuthorizedException(Exception innerException) {

        this(innerException, null);
    }

    public UnAuthorizedException(Exception innerException, String accessKey) {

        super(innerException);

        String message;
        Locale locale = LocaleContextHolder.getLocale();
        if (StringUtils.isEmpty(accessKey))
            message = messageSource.getMessage("exception.access-denied", null, locale);
        else
            message = messageSource.getMessage("exception.access-denied", new Object[]{accessKey}, locale);
        this.response = new ErrorResponse(ErrorType.UnAuthorized, null, message);
    }
}