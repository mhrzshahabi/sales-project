package com.nicico.sales.exception;

import lombok.Getter;
import org.springframework.web.servlet.HandlerInterceptor;

@Getter
public abstract class BaseException extends RuntimeException implements HandlerInterceptor {

    protected ErrorResponse response;

    BaseException() {

        this(null);
    }

    BaseException(Exception innerException) {

        super(innerException);
    }
}
