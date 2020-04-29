package com.nicico.sales.exception;

import com.nicico.sales.enumeration.ErrorType;
import lombok.Getter;

import java.util.Arrays;
import java.util.Date;
import java.util.Optional;

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

    ErrorResponse(ErrorType errorCode, String field, String message) {

        this.field = field;
        this.message = message;
        this.errorCode = errorCode;

        Optional<StackTraceElement> stackTraceElement = Arrays.stream(Thread.currentThread().getStackTrace()).filter(q -> q.getClassName().matches("com\\.nicico\\.sales\\.service\\..*")).findFirst();
        if (stackTraceElement.isPresent()) {

            StackTraceElement element = stackTraceElement.get();
            this.fileName = element.getFileName();
            this.className = element.getClassName();
            this.methodName = element.getMethodName();
            this.lineNumber = element.getLineNumber();
        } else {

            this.lineNumber = -1;
            this.fileName = null;
            this.className = null;
            this.methodName = null;
        }

        this.timeStamp = new Date().getTime();
    }
}