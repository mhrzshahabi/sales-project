package com.nicico.sales.exception;

import com.nicico.sales.enumeration.ActionType;
import com.nicico.sales.enumeration.ErrorType;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
public class ErrorResponse {

    private final String field;
    private final String message;
    private final ErrorType errorCode;

    private final long timeStamp;

    private final String fileName;
    private final String className;
    private final String methodName;
    private final Integer lineNumber;
    @Setter
    private final ActionType actionType;

    ErrorResponse(ErrorType errorCode, String field, String message) {

        this.field = field;
        this.message = message;
        this.errorCode = errorCode;

        StackTraceElement element = Thread.currentThread().getStackTrace()[1];
        this.fileName = element.getFileName();
        this.className = element.getClassName();
        this.methodName = element.getMethodName();
        this.lineNumber = element.getLineNumber();

        this.actionType = null;
        this.timeStamp = new Date().getTime();
    }
}