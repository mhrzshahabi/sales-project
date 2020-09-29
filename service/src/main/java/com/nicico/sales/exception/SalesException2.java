package com.nicico.sales.exception;

import com.nicico.sales.enumeration.ErrorType;
import lombok.Getter;

@Getter
public class SalesException2 extends BaseException {

    public SalesException2() {

        this(ErrorType.Unknown);
    }

    public SalesException2(ErrorType errorType) {

        this(errorType, null);
    }

    public SalesException2(Exception innerException) {

        this(innerException, ErrorType.Unknown, "", innerException.getMessage());
    }

    public SalesException2(ErrorType errorType, String field) {

        this(errorType, field, null);
    }

    public SalesException2(ErrorType errorType, String field, String message) {

        this(null, errorType, field, message);
    }

    public SalesException2(Exception innerException, ErrorType errorType, String field, String message) {

        super(innerException);
        this.response = new ErrorResponse(errorType, field, message);
    }
}